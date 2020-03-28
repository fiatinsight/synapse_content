# Synapse Content

- Add direct upload JS / CSS
- Add CORS policy to S3 bucket to support direct uploads

A gem for managing content with [@fiatinsight](https://github.com/fiatinsight/)'s Synapse product.

## Getting started

Add this line to your application's `Gemfile`:

```ruby
source "https://rubygems.pkg.github.com/fiatinsight" do
  gem "synapse_content"
end
```

Then `bundle` and run the required migrations directly by typing:

    $ rake db:migrate

Create an initializer at `config/initializers/synapse_content.rb` to set any required globals for your implementation. You should set any variables that pertain to parts of the gem you'll want to use. Variables give you the chance to pass namespacing into the engine's actions:

```ruby
SynapseContent.configure do |config|
  config.new_message_redirect_path = "my_namespace_path"
  config.new_page_path = "my_namespace_path"
  config.view_page_path = "my_namespace_path"
end
```

> Note: For a full list of configuration options, see [here](https://github.com/fiatinsight/synapse_content/blob/master/lib/synapse_content/configuration.rb). *This is being deprecated* in favor of custom redirect paths and variables within form helpers, for example [here](https://github.com/fiatinsight/synapse_content/blob/master/app/views/synapse_content/articles/_new.html.erb).

Then mount the engine in your `routes.rb` file:

```ruby
mount SynapseContent::Engine => "/content"
```

You can also mount the engine within a namespace, for example:

```ruby
namespace :account do
  mount SynapseContent::Engine => "/content"
  # More routes here...
end
```

## Dependencies

The engine supplies minimally formatted output so that you can influence designs within your main application. It includes dependencies for [simple_form](https://github.com/plataformatec/simple_form), [trix-rails](https://github.com/kylefox/trix), [audited](https://github.com/collectiveidea/audited), [recaptcha](https://github.com/ambethia/recaptcha), [meta-tags](https://github.com/kpumuk/meta-tags), and [activestorage-validator](https://github.com/aki77/activestorage-validator). It requires that you've set up [Active Storage](https://edgeguides.rubyonrails.org/active_storage_overview.html#setup) in your main app. It also requires a `Tokenable` concern (i.e., generating a `token` on a create callback) for models to handle tokenization.

It assumes&mdash;but doesn't require&mdash;that you're using Bootstrap and [fiat_ui](https://github.com/fiatinsight/fiat_ui), as well as [fiat_notifications](https://github.com/fiatinsight/fiat_notifications).

> Note: A `User` class is currently required by the `mention_users` method on the `Comment` model. This assumes, too, that `fiat_notifications` is installed, which will eventually be a dependency for this gem.

## Content types

This engine supplies a variety of content types that can be invoked in custom configurations to do whatever you need. There are some guiding ideas, though, that'll help to implement the available resources better.

### Pages and articles

#### Creating

Pages and articles are basic content types. Pages are intended for more permanent content, and articles are designed to be more transient / ephemeral. You can invoke a new page or article by pointing to:

```ruby
= link_to send("your_new_article_path", publisher_type: nil, publisher_id: nil)
```

You'll need to create a custom `new.html.erb` file in your app at the relevant location, and include the following variables / partial:

```ruby
locals = {
    article: SynapseContent::Article.new,
    url: synapse_content.articles_path,
    publisher_type: params[:publisher_type],
    publisher_id: params[:publisher_id],
    btn_classes: 'btn btn-primary',
    edit_redirect_path: 'example_path',
    edit_redirect_variable: 'Current.organization' # Optional; set to `nil` to use @article after create action
    }

= render partial: 'synapse_content/articles/new', locals: locals
```

#### Editing

Editing an article or page requires a little more information. Create an `edit.html.erb` view with the following information:

```ruby
locals = {
  page: SynapseContent::Article.find(params[:id]),
  article_update_url: synapse_content.article_path,
  new_content_block_url: synapse_content.new_content_block_path(publishable_type: 'SynapseContent::Page', publishable_id: params[:id]),
  content_block_path: '/publication/content_blocks', # Local
  btn_classes: 'btn btn-success',
  nested_parent_id: nil, # Can be deprecated?
  publisher_type: nil,
  publisher_id: nil,
  destroy_redirect_path: 'publisher_path',
  destroy_redirect_variable: SynapseContent::Article.find(params[:id]).publisher.id # Optional
  }

= render partial: 'synapse_content/articles/edit', locals: locals
```

### Content blocks

Content blocks are granular elements used to build pages and articles. By default, the `Page` and `Article` classes in this gem use `has_many` polymorphic associations for content blocks as `publishable`. You can also extend a similar relationship to any model(s) in your main app. For example:

```ruby
class MyPage < ApplicationRecord
  # ...
  has_many :synapse_content_content_blocks, as: :publishable, class_name: 'SynapseContent::ContentBlock'
end
```

Content blocks also require a `block_type` value that can be set to `text`, `image`, or `buttons`. The type of block determines what fields are made available to utilize. Content blocks with images use Active Storage to store and process image files.

> Note: More block types will be forthcoming.

### Authors

Authors can be created and associated with articles.

> TODO: Extend the `Author` class to accommodate more information, and to associate with other main app classes, like `User`.

### Messages and comments

Messages enable threaded content, similar to email. Adding comments to messages allows you to extend them indefinitely. A message automatically `has_many` comments; but comments can also be added to other content objects in the engine, or within your main app, using a similar `commentable` polymorphic relationship.

You only need to supply a `subject` to create a message.

> TODO: This section needs more detail around working with engine-supplied message forms, writing your own forms, including custom fields and labels, etc.

#### reCaptcha v3

Messages allow you to add reCaptcha v3 to your message form. The `create` action checks for the `verify_recaptcha` method and processes it with that if available. The v3 action you include in a new message form must be `create_message`, for example: `= recaptcha_v3(action: 'create_message')`.

### Attachments

Attachments are standalone content objects that use Active Storage to store files.

> TODO: This content type is undeveloped. Extrapolating current attachment logic, routing, etc., in conjunction w/ best practice Active Storage use is required. (See [this issue](https://github.com/fiatinsight/synapse_content/issues/6).)

### Custom fields

Custom fields can be programmed into forms on the main application. Within the engine, they're automatically associated as `publishable` with messages, articles, and pages. Each of these classes also accepts nested attributes for custom fields, allowing you to include them in custom forms within your main application.

### Content labels

Content labels are designed to work like Gmail labels: They're flattened objects that can be associated with individual instances of a class to make taxonomies easier and super flexible. Content labels are automatically associated to pages, articles, and messages in the engine via the `ContentLabelAssignment` class as `assignable`.

### Navigation

> TODO: Navigation items and groups, drawing in engine classes, need to be extrapolated from current use. (See [this issue](https://github.com/fiatinsight/synapse_content/issues/5).)

## Snoozing

Snoozing is available for messages, by default. You can create a link to snooze something like this:

```ruby
= link_to "Snooze this", synapse_content.new_snooze_path(snoozable_type: "SynapseContent::Message", snoozable_id: @message.id, snoozer_type: "User", snoozer_id: current_user.id), remote: true
```

Set up automatic unsnoozing in your Heroku app using `rake unsnooze_things` in a cron scheduler.

## Publishers

Content can optionally be assigned to a polymorphic `publisher` as a class from your main app. This can also be omitted, in case there's only one content creator (e.g., in a simple, non-scaled application). You can listen for `publisher` content on any model(s) you want:

```ruby
class Organization < ApplicationRecord
  # ...
  has_many :synapse_pages, as: :publisher, class_name: 'SynapseContent::Page'
  has_many :synapse_articles, as: :publisher, class_name: 'SynapseContent::Article'
end
```

## Routing

### New items

Depending on where you mount the engine, routing to its resources will work differently. For example, within an `account` namespace, a new content block could be created using something like:

```ruby
link_to "New block", account_synapse_content.new_content_block_path(publishable_type: "Page", publishable_id: @page.id)
```

### Updating items

In this case, updating content would require passing in the full namespace so that `synapse_content` can handle a nested path helper in its forms. That means including the object you want to work with, e.g., setting a `content_block` variable, as well as the `url` variable of the path you want to work with:

```ruby
content_block = SynapseContent::ContentBlock.find(your_content_block_id)
= render partial: 'synapse_content/content_blocks/form', locals: { content_block: content_block, url: account_synapse_content.content_block_path(content_block) }
```

Creating a new entry would take similar arguments:

```ruby
= render partial: 'synapse_content/messages/new', locals: { message: SynapseContent::Message.new, url: account_synapse_content.messages_path }
# Note the use of content_blocks_path and not new_content_block_path
```

### Redirecting

In addition to the default redirect variables in your initializer, you can alternatively pass a `redirect_path` variable within the `url` parameter of a form. This processes using the `send()` function, so you can write it like this:

```ruby
= render partial: 'synapse_content/messages/new', locals: { message: SynapseContent::Message.new, url: account_synapse_content.messages_path(redirect_path: root_path) }
```

Or like this:

```ruby
= render partial: 'synapse_content/messages/new', locals: { message: SynapseContent::Message.new, url: account_synapse_content.messages_path(redirect_path: "'account_synapse_content.message_path', @message") }
```

### Notices

You can pass a `notice` variable in the `url` parameter, too:

```ruby
= render partial: 'synapse_content/messages/new', locals: { message: SynapseContent::Message.new, url: account_synapse_content.messages_path(redirect_path: root_path, notice: "That was awesome. Well done!") }
```

### Displaying items

Displaying content just requires that you use the typical associations. For example, if you wanted to display the default partial for a content block provided by `synapse_content` you could put:

```ruby
@page.synapse_content_content_blocks.each do |i|
  = render partial: 'synapse_content/content_blocks/show', locals: { content_block: i, my_classes: 'custom_classes_here' }
end
```

## Extending classes

You can extend classes by using decorators at `/app/decorators/**/*_decorator*.rb`

For example, a file called `/app/decorators/models/synapse_content/message_decorator.rb` might include:

```ruby
SynapseContent::Message.class_eval do
  def new_method
    # Some code
  end
end
```
> Note: Be sure to restart your application when introducing decorators

## Customization

You can use the gem resources directly, or wrap them into custom namespaces, views, and controller logic within your main app. For example, after mounting it within a namespace called `account`, you could create a series of controllers under your `AccountController` to handle provided resources, e.g., `Account::PagesController` or `Account::ArticlesController`. You can do this for some resources or all of them. Make sure to create routes for each resource type you want to handle:

```ruby
namespace :account do
  mount SynapseContent::Engine => "/publication"
  resources :pages
  resources :articles
end
```

## Development

To build this gem for the first time, run `gem build synapse_content.gemspec` from the project folder.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fiatinsight/synapse_content.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
