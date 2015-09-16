require 'active_support/core_ext/array'
require 'redis/objects/pagination/paginator/collection_proxy'

class Redis
  module Objects
    module Pagination
      class Paginator
        include CollectionProxy

        def initialize(object, method_name, options = {})
          @object = object
          @method_name, *@method_args =
            case method_name
            when Hash
              name, args = method_name.first
              [name, *Array.wrap(args)]
            else
              Array.wrap(method_name)
            end

          raise InvalidArgument if object.method(@method_name).arity.abs < 2

          @limit, @offset, @total_count = (options[:limit] || ::Redis::Objects::Pagination.config.default_per_page).to_i, options[:offset].to_i, options[:total_count]
        end

        # Change page
        #
        # @param [Integer] page number
        # @return [Paginator]
        def page(num = 1)
          num = num.to_i - 1
          num = [num, 0].max
          offset(@limit * num)
        end

        # Set number of items per page
        #
        # @param [Integer] number of items per page
        # @return [Paginator]
        def per(num)
          limit(num).offset((current_page - 1) * num)
        end

        # Set limit
        #
        # @param [Integer] limit
        # @return [Paginator]
        def limit(num)
          self.class.new @object, [@method_name, *@method_args], limit: num, offset: @offset
        end

        # Set offset
        #
        # @param [Integer] offset
        # @return [Paginator]
        def offset(num)
          self.class.new @object, [@method_name, *@method_args], limit: @limit, offset: num
        end

        # Total number of items
        #
        # @return [Integer]
        def total_count
          @total_count || @object.size
        end

        # Total number of pages
        #
        # @return [Integer]
        def total_pages
          (total_count / @limit.to_f).ceil
        end

        # Current page number
        #
        # @return [Integer]
        def current_page
          @offset / @limit + 1
        end

        # Next page number
        #
        # @return [Integer]
        def next_page
          current_page + 1 unless last_page?
        end

        # Previous page number
        #
        # @return [Integer]
        def prev_page
          current_page - 1 unless first_page?
        end

        # First page?
        #
        # @return [Boolean]
        def first_page?
          current_page == 1
        end

        # Last page?
        #
        # @return [Boolean]
        def last_page?
          current_page >= total_pages
        end

        # Limit value
        #
        # @return [Integer]
        def limit_value
          @limit
        end

        # Offset value
        #
        # @return [Integer]
        def offset_value
          @offset
        end

        # Fetch collection of current page
        #
        # @return [Array]
        def paginate
          args = [start_index, end_index, *@method_args].compact
          @object.send @method_name, *args
        end

        private

        def start_index
          @offset
        end

        def end_index
          index = @offset + @limit - 1
          if total_count <= index
            total_count
          else
            index
          end
        end
      end
    end
  end
end
