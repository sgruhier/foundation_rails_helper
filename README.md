# Foundation Rails Helper [![Build Status](https://secure.travis-ci.org/sgruhier/foundation_rails_helper.png)](http://travis-ci.org/sgruhier/foundation_rails_helper)

Gem for Rails 4.1+ applications that use the excellent [Zurb Foundation framework](https://github.com/zurb/foundation-rails).

Includes:

* A custom FormBuilder that generates a form using the Foundation framework classes. It replaces the current `form_for`, so there is no need to change your Rails code. Error messages are properly displayed.

* A `display_flash_messages` helper method that uses Zurb Foundation Callout UI.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'foundation-rails', '~> 6.0' # required
gem 'foundation_rails_helper', '~> 3.0'
```

And then execute:

```bash
$ bundle
```

## Compatibility

* Only Rails 4.1/4.2/5, and Foundation 6 are fully supported
* Some features may work with Foundation 5 and older, but results may vary, and markup which exists only for those versions will be gradually removed
* Legacy branches exist for Rails 3, 4.0, and Foundation 5 (see the rails3, rails4.0, and foundation-5 branches). These are not actively supported, and fixes are not retroactively applied, but pull requests are welcome.
* We test against ruby versions 2.1 and up. This gem may still work fine on 1.9.3, but your mileage may vary


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
  <thead>
    <tr>
      <th>Form</th>
      <th>Form with errors</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td valign='top'>
        <img src="https://cloud.githubusercontent.com/assets/1400414/18522106/8b981524-7a63-11e6-8450-0605cc310205.png"/>
      </td>
      <td valign='top'>
        <img src="https://cloud.githubusercontent.com/assets/1400414/18522107/8d0bfa24-7a63-11e6-8c0a-12757528b9ee.png"/>
      </td>
    </tr>
  </tbody>
</table>

### Flash messages

![Flash-message](https://cloud.githubusercontent.com/assets/1400414/18522256/3d13c97e-7a64-11e6-9ee2-33adc93cd573.png "Flash-message")

## Usage

### Flash Messages

To use the built in flash helper, add `<%= display_flash_messages %>` to your layout file (eg. *app/views/layouts/application.html.erb*).

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
</form>
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

Preventing the generation of labels can be accomplished three ways. To disable on a form element:
```ruby
f.text_field :name, label: false
```
For all form elements, add the option: `auto_labels: false` to the form helper.  To disable for all forms in you project, use the `auto_labels` config option, see the Configuration section for more information.

Change the label text and add a class on the label:

```ruby
f.text_field :name, label: 'Nombre', label_options: { class: 'large' }
```

If the help_text option is specified

```ruby
f.text_field :name, help_text: "I'm a text field"
```

an additional p element will be added after the input element:

```html
<p class="help-text">I'm a text field</p>
```

### Submit Button

The 'submit' helper wraps the rails helper and sets the class attribute to "success button" by default.

```ruby
f.submit
```

generates:

```html
<input class="success button" name="commit" type="submit" value="Create User">
```

Specify the class option to override the default classes.

### Errors

On error,

```ruby
f.email_field :email
```

generates:

```html
<label class="is-invalid-label" for="user_email">Email</label>
<input class="is-invalid-input" id="user_email" name="user[email]" type="email" value="">
<small class="form-error is-visible">can't be blank</small>
```

The class attribute of the 'small' element will mirror the class attribute of the 'input' element.

If the `html_safe_errors: true` option is specified on a field, then any HTML you may have embedded in a custom error string will be displayed with the html_safe option.

### Prefix and Postfix
Simple prefix and postfix span elements can be added beside inputs.
```ruby
f.text_field :name, prefix { value: 'foo', small: 2, large: 3 }
```
generates
```html
<div class="row collapse">
  <div class="small-2 large-3 columns">
    <span class="prefix">foo</span>
  </div>
  <div class="small-10 large-9 columns">
    <input type="text" name="user[name]" id="user_name">
  </div>
</div>
```


## Configuration
Add an initializer file to your Rails app: *config/initializers/foundation_rails_helper.rb*
containing the following block:

```ruby
FoundationRailsHelper.configure do |config|
  # your options here
end
```

### Submit Button Class
To use a different class for the [submit button](https://github.com/sgruhier/foundation_rails_helper#submit-button) used in `form_for`, add a config named **button_class**:
```ruby
# Default: 'success button'
config.button_class = 'large hollow secondary button'
```

Please note, the button class can still be overridden by an options hash.

### Ignored Flash Keys
The flash helper assumes all flash entries are user-viewable messages.
To exclude flash entries which are used for storing state
(e.g. [Devise's `:timedout` flash](https://github.com/plataformatec/devise/issues/1777))
you can specify a blacklist of keys to ignore with the **ignored_flash_keys** config option:
```ruby
# Default: []
config.ignored_flash_keys = [:timedout]
```

### Auto Labels
If you prefer to not have the form builder automatically generate labels, set `auto_labels` to false.
```ruby
# Default: true
config.auto_labels = false
```

## Contributing

See the [CONTRIBUTING](CONTRIBUTING.md) file.

## Copyright

Sébastien Gruhier (http://xilinus.com) - MIT LICENSE
