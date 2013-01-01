# FoundationRailsHelper [![Build Status](https://secure.travis-ci.org/sgruhier/foundation_rails_helper.png)](http://travis-ci.org/sgruhier/foundation_rails_helper)

Gem for Rails 3 applications that use the excellent Zurb Foundation framework.

* [Zurb Foundation](https://github.com/zurb/foundation)
* [Zurb Foundation Rails](https://github.com/zurb/foundation-rails)

So far it includes:

* A custom FormBuilder that generates a form using the Foundation framework. It replaces the current `form_for` so you don't have to change your Rails code. Error messages are properly displayed.

* A `display_flash_messages` helper method that uses Zurb Foundation Alerts UI.

This gem has been used with Rails 3.1, 3.2 and ruby 1.9.2, 1.9.3. It should work for Rails 3.0.

## Screenshots

### Forms
A classic devise sign up view will look like this:

```erb
<%= form_for(resource, :as => resource_name, :url => registration_path(resource_name)) do |f| %>
  <%= f.email_field :email %>
  <%= f.password_field :password %>
  <%= f.password_field :password_confirmation %>

  <%= f.submit %>
<% end %>
```

<table>
  <tr>
    <th>Form</th>
    <th>Form with errors</th>
  </tr>
  <tr>
    <td valign='top'> <img src="http://dl.dropbox.com/u/517768/sign-up.png"/></td>
    <td valign='top'> <img src="http://dl.dropbox.com/u/517768/sign-up-with-errors.png"/></td>
  </tr>
</table>

### Flash messages

![Flash-message](http://dl.dropbox.com/u/517768/flash.png "Flash-message")

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zurb-foundation'
gem 'foundation_rails_helper'
```

And then execute:

```bash
$ bundle
```

## Usage

There is nothing additional to do for form helpers.

To get access to `display_flash_messages` in your views, add

```ruby
include FoundationRailsHelper::FlashHelper
```

to `app/helpers/application_helper.rb`

## TODO

* Handle more UI components
* Make something for ajax forms

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Sébastien Gruhier (http://xilinus.com, http://v2.maptimize.com) - MIT LICENSE - 2012