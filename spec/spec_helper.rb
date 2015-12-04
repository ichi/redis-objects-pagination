$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'rspec/its'
require 'rspec/collection_matchers'
require 'mock_redis'
require 'redis/objects/pagination'

Redis.current = MockRedis.new

RSpec.configure do |config|
  config.after :each do
    Redis.current.flushdb
  end
end
