# FoundationRailsHelper [![Build Status](https://secure.travis-ci.org/sgruhier/foundation_rails_helper.png)](http://travis-ci.org/sgruhier/foundation_rails_helper)

Gem for rails 3 application that uses the excellent Zurb Foundation framework.

* [Zurb Foundation](https://github.com/zurb/foundation)
* [Zurb Foundation Rails](https://github.com/zurb/foundation-rails)

It includes so far

* A custum FormBuilder to generate form with Foundation framework. It replaces the current `form_for` so you don't have to
change your rails code.
Errors messages are propertly displayed
* A `display_flash_messages` helper method to use Zurb Foundation Alerts UI

I use this gem only been with Rails 3.1 and ruby 1.9.2. It should work for Rails 3.0.

## Screenshots

A classic devise sign up views will look like this:

```erb
<%= form_for(resource, :as => resource_name, :url => registration_path(resource_name)) do |f| %>
  <%= f.email_field :email %>
  <%= f.password_field :password %>
  <%= f.password_field :password_confirmation %>

  <%= f.submit "S'enregistrer" %>
<% end %>
```

![Sign-up](http://dl.dropbox.com/u/517768/sign-up.png "Sign-up")

With errors

![Sign-up-with-errors](http://dl.dropbox.com/u/517768/sign-up-with-errors.png "Sign-up-with-errors")

And success flash message will be display like that:

![Flash-message](http://dl.dropbox.com/u/517768/flash.png "Flash-message")

## Installation

Add this line to your application's Gemfile:

    gem "zurb-foundation"
    gem 'foundation_rails_helper'

And then execute:

    $ bundle


## Usage

For form helpers, nothing to do,

To get access to `display_flash_messages` in your views add in your `app/helpers/application_helper.rb` file

```
  include FoundationRailsHelper::FlashHelper
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Copyright
Sébastien Gruhier (http://xilinus.com, http://v2.maptimize.com) - MIT LICENSE - 2012