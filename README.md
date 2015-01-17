# FoundationRailsHelper [![Build Status](https://secure.travis-ci.org/sgruhier/foundation_rails_helper.png)](http://travis-ci.org/sgruhier/foundation_rails_helper)

Gem for Rails 4.1.x applications that use the excellent Zurb Foundation framework.

* [Zurb Foundation](https://github.com/zurb/foundation)
* [Zurb Foundation Rails](https://github.com/zurb/foundation-rails)

So far it includes:

* A custom FormBuilder that generates a form using the Foundation framework. It replaces the current `form_for` so you don't have to change your Rails code. Error messages are properly displayed.

* A `display_flash_messages` helper method that uses Zurb Foundation Alerts UI.

#### Compatibility

* Only Rails 4.1 and Foundation 4 and 5 are fully supported
* Some features may work with Foundation 3 and older, but results may vary, and markup which exists only for those versions will be gradually removed
* Legacy branches exist for Rails 3 and 4.0 (see the rails3 and rails4.0 branches). These are not actively supported, and fixes are not retroactively applied, but pull requests are welcomed.


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

### Flash Messages

To get access to `display_flash_messages` in your views, add

```ruby
include FoundationRailsHelper::FlashHelper
```

to `app/helpers/application_helper.rb`

## Usage

### form_for

Form_for wraps the standard rails form_for helper.

```erb
<%= form_for @user do |f| %>
  ...
<% end %>
```

generates:

```html
<form accept-charset="UTF-8" action="/users" class="new_user" id="new_user" method="post">
  ...
```

### text_field and Field Helpers

Field helpers add a label element and an input of the proper type.

```ruby
f.text_field :name
```

generates:

```html
<label for="user_email">Name</label>
<input id="user_name" name="user[name]" type="text">
```

Prevent the generation of a label:

```ruby
f.text_field :name, label: false
```

Change the label text and add a class on the label:

```ruby
f.text_field :name, label: 'Nombre', label_options: { class: 'large' }
```

If the hint option is specified

```ruby
f.text_field :name, hint: "I'm a text field"
```

an additional span element will be added after the input element:

```html
<span class="hint">I'm a text field</span>
```

### Submit Button

The 'submit' helper wraps the rails helper and sets the class attribute to "small radius success button" by default.

```ruby
f.submit
```

generates:

```html
<input class="small radius success button" name="commit" type="submit" value="Create User">
```

Specify the class option to override the default classes.

### Errors

On error,

```ruby
f.email_field :email
```

generates:

```html
<label class="error" for="user_email">Email</label>
<input class="error" id="user_email" name="user[email]" type="email" value="">
<small class="error">can't be blank</small>
```

The class attribute of the 'small' element will mirror the class attribute of the 'input' element.

If the `html_safe_errors: true` option is specified on a field, then any HTML you may have embedded in a custom error string will be displayed with the html_safe option.

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

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/sgruhier/foundation_rails_helper/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
