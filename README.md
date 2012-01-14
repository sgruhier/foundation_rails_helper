Still in alpha release, don't use it yet.


# FoundationRailsHelper

Gem for rails 3 application that uses the excellent Zurb Foundation framework.
It includes so far

* A custum FormBuilder to generate form with Foundation framework. It replaces the current `form_for` so you don't have to
change your rails code.
Errors messages are propertly displayed
* A `display_flash` helper method to use Zurb Foundation Alerts UI

This gem has only been tested with Rails 3.1 and ruby 1.9.2. 

## Screenshots

A classic devise sign up views will look like this:

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

Nothing to do, just add this gem to your Gemfile

To get access to `display_flash` in your views add in your `app/helpers/application_helper.rb`

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