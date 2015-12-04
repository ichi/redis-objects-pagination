# Redis::Objects::Pagination

Pagination for [redis-objects](https://github.com/nateware/redis-objects).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redis-objects-pagination'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis-objects-pagination

## Usage

### `Redis::List`

```ruby
Redis::List.new('list_key').paginator(:range).page(2).paginate
```

### `Redis::SortedSet`

```ruby
Redis::SortedSet.new('sorted_set_key').paginator(:range).page(2).paginate
```

```ruby
Redis::SortedSet.new('sorted_set_key').paginator(:revrange).page(2).paginate
```

### with options

```ruby
Redis::List.new('list_key').paginator(:range, offset: 10, limit: 10).page(2).paginate
```

```ruby
Redis::SortedSet.new('sorted_set_key').paginator(:revrange, with_scores: true).page(2).paginate
```

### paginator methods

```ruby
paginator = Redis::List.new('list_key').paginator(:range)

paginator.page(2)       # => Paginator
paginator.per(20)       # => Paginator
paginator.total_count   # => Integer
paginator.total_pages   # => Integer
paginator.current_page  # => Integer
paginator.next_page     # => Integer
paginator.prev_page     # => Integer
paginator.first_page?   # => Boolean
paginator.last_page?    # => Boolean

paginator.paginate      # => Array
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/redis-objects-pagination/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
