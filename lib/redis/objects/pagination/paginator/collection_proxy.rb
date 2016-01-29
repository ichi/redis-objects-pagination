class Redis
  module Objects
    module Pagination
      class Paginator
        module CollectionProxy
          include Enumerable
          delegate :each, to: :to_a

          def to_ary
            paginate
          end
          alias_method :to_a, :to_ary
        end
      end
    end
  end
end
