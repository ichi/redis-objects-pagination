$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'redis/objects/pagination'

REDIS_HOST = ENV['REDIS_HOST'] || 'localhost'
REDIS_PORT = ENV['REDIS_PORT'] || 6379
REDIS_DB   = ENV['REDIS_DB'] || 10
REDIS_HANDLE = Redis.new(host: REDIS_HOST, port: REDIS_PORT, db: REDIS_DB)
Redis.current = REDIS_HANDLE


RSpec.configure do |config|
  config.after :each do
    Redis.current.flushdb
  end
end
