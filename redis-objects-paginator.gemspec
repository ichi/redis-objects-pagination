# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis/objects/pagination/version'

Gem::Specification.new do |spec|
  spec.name          = "redis-objects-pagination"
  spec.version       = Redis::Objects::Pagination::VERSION
  spec.authors       = ["ichi"]
  spec.email         = ["ichi.ttht.1@gmail.com"]

  spec.summary       = %q{Pagination for redis-objects.}
  spec.description   = %q{Pagination for redis-objects.}
  spec.homepage      = "https://github.com/ichi/redis-objects-pagination"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "redis-objects", ">= 1.2"
  spec.add_dependency 'activesupport', '>= 3.0.0'

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "mock_redis"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-doc"
end
