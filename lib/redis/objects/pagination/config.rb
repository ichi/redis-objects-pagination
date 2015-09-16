require 'active_support/configurable'

class Redis
  module Objects
    module Pagination
      class << self
        def configure(&block)
          yield config
        end

        def config
          @config ||= Configuration.new
        end
      end

      class Configuration
        include ::ActiveSupport::Configurable

        config_accessor(:default_per_page){ 25 }
      end
    end
  end
end
