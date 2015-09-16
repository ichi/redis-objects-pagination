class Redis
  module Objects
    module Pagination
      module Paginatable

        # Create Paginator object by method name
        #
        # @param [Symbol, Hash<Symbol, Array>] method name only or method name and arguments hash
        # @param [Hash] options
        # @return [Paginator]
        # @option options [Integer] :limit = ::Redis::Objects::Pagination.config.default_per_page
        # @option options [Integer] :offset = 0
        # @option options [Integer] :total_count
        def paginator(method_name, options = {})
          Paginator.new(self, method_name, options)
        end
      end
    end
  end
end
