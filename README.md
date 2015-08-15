# FDotErrors

Add `f.errors(:method)` to Rails view.

## Supported versions

Rails 4.2.x

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'f_dot_errors'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install f_dot_errors

## Usage

```ruby
# app/models/post.rb
# sure we support ActiveRecord model
class Post < Struct.new(:author_name, :body, :updated_at)
  include ActiveModel::Model
end


# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do |format|
        format.html { redirect_to posts_path }
      end
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end
end
```

```erb
# app/views/posts/new.html.erb
<%= form_for(@post) do |f| %>
  <%= f.text_field(:author_name) %>
  <%= f.errors(:author_name) %>

  <%= f.text_field(:body) %>
  <%= f.errors(:body) %>
<% end %>
```

If `@post` has errors about `:author_name`, `f.errors` render errors:

```html
<form class="new_post" id="new_post" action="/posts" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
  <input type="text" value="" name="post[author_name]" id="post_author_name" />
  <div class="field_with_errors">Author name can't be empty</div>
  <input type="text" value="" name="post[boyd]" id="post_boyd" />
</form>
```

## Configuring error wrapper

By default, these proc is used:

```ruby
Proc.new { |instance, method, template|
  msgs = instance.errors.full_messages_for(method).join("\n")
  "<div class=\"field_with_errors\">#{msgs}</div>".html_safe
}
```

If you would use a different proc, you can configure in your initializer.

```ruby
FDotErrors.configure do |c|
  c.field_error_proc = Proc.new { |instance, method, template|

    lis = instance.errors.full_messages_for(method).map do |msg|
      template.content_tag(:li, msg, {class: "field_with_errors_list_item"}, false)
    end.join("\n").html_safe
    template.content_tag(:ul, lis, class: "field_with_errors_list")
  }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yui-knk/f_dot_errors. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

