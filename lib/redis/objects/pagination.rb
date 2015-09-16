require 'redis/objects'
require 'redis/objects/pagination/version'
require 'redis/objects/pagination/config'
require 'redis/objects/pagination/errors'
require 'redis/objects/pagination/paginatable'

class Redis
  module Objects
    module Pagination
      autoload :Paginator,    'redis/objects/pagination/paginator'

      ::Redis::List.send      :include, Paginatable
      ::Redis::SortedSet.send :include, Paginatable
    end
  end
end
