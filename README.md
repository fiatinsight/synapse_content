# Fiat Publication

This engine is designed to be used by Fiat Insight developers on Rails projects that require a basic CMS.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fiat_publication'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fiat_publication

## Dependencies

The gem is designed to supply minimally formatted output so that you can influence designs within your main application. It requires [simple_form](https://github.com/plataformatec/simple_form), [trix-rails](https://github.com/kylefox/trix), and that you've set up Active Storage in your main app. It also requires a `Tokenable` concern for models to handle tokenization. It assumes (but doesn't require) that you're using Bootstrap and [fiat_ui](https://github.com/fiatinsight/fiat_ui).

## Setup

Install the migrations in your app root folder by running:

    $ rails fiat_publication:install:migrations
    $ rake db:migrate

Then mount the engine in your `routes.rb` file:

```ruby
mount FiatPublication::Engine => "/publication"
```

You can also mount the engine within a namespace, for example:

```ruby
namespace :account do
  mount FiatPublication::Engine => "/publication"
  # More routes here...
end
```

### Content blocks

Content blocks are granular elements used to build publications. By default, they belong to a polymorphic `publishable` object. You can use any model(s) in your app as `publishable`. To associate content blocks with your object(s), for example with a page, include the following on your model:

```ruby
class Page < ApplicationRecord
  # ...
  has_many :fiat_publication_content_blocks, as: :publishable, class_name: 'FiatPublication::ContentBlock'
end
```

### Pages and articles

Pages and articles are available through the engine, too. They belong to a polymorphic `publisher` object. You can use any model(s) in your app for this (e.g., organizations, accounts, etc.). For example:

```ruby
class Organization < ApplicationRecord
  # ...
  has_many :fiat_publication_pages, as: :publisher, class_name: 'FiatPublication::Page'
  has_many :fiat_publication_articles, as: :publisher, class_name: 'FiatPublication::Article'
end
```

### Authors

Forthcoming...

### Routing

Depending on where you mount the engine, routing to its resources will work differently. For example, within an `account` namespace, a new content block could be created using something like:

```ruby
link_to "New block", account_fiat_publication.new_content_block_path(publishable_type: "Page", publishable_id: @page.id)
```

In this case, updating content would require passing in the full namespace so that `fiat_publication` can handle a nested path helper in its forms:

```ruby
content_block = FiatPublication::ContentBlock.find(your_content_block_id)
= render partial: 'fiat_publication/content_blocks/form', locals: { content_block: content_block, url: account_fiat_publication.content_block_path(content_block) }
```

Displaying content just requires that you use the typical associations. For example, if you wanted to display the default partial for a content block provided by `fiat_publication` you could put:

```ruby
@page.fiat_publication_content_blocks.each do |i|
  = render partial: 'fiat_publication/content_blocks/show', locals: { content_block: i, my_classes: 'custom_classes_here' }
end
```

## Development

To build this gem for the first time, run `gem build fiat_publication.gemspec` from the project folder.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fiatinsight/fiat_publication.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
