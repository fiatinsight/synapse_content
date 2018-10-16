# Fiat Publication

This gem is designed to be used by Fiat Insight developers on Rails projects that require a basic CMS.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fiat_publication'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fiat_publication

## Setup

Create an initializer at `config/initializers/fiat_publication.rb` to set some global configs:

```ruby
# Config stuff here...
```

Install the migrations in your app root folder by running:

    $ rails fiat_publication:install:migrations
    $ rake db:migrate

## Development

To build this gem for the first time, run `gem build fiat_publication.gemspec` from the project folder.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fiatinsight/fiat_publication.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
