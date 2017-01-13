## Version 3.0.0
* Added Foundation 6 support
* Added auto_labels config

## Version 2.0
This will be used for Foundation 5 support

### Breaking changes:
* Dropped support for Ruby 1.9.3
* display_flash_messages now requires the key_matching hash to be prefixed with the keyword argument :key_matching

### Features:
* Add Rubocop code style linting

## Version 1.2.2
* Fix Rails 5 deprecation warnings about alias_method_chain
* Allow Capybara to be upgraded beyond 2.6.x

## Version 1.2.1
* Lock Capybara at 2.6.x

## Version 1.2.0
* Allow Rails 5 to be used

## Version 1.1.0
* Form Helper: [Prefix and
  Postfix](http://foundation.zurb.com/sites/docs/v/5.5.3/components/forms.html#pre-postfix-labels-amp-actions) are now supported  (PR #104 thanks djkz)
* Flash Helper: a list of keys to be ignored can be specified - e.g. keys which are only used internally to pass data, not user-viewable messages(fix for #98)
* FIX: Hints are added as span elements (PR #96 thanks collimarco)
* FIX: Labels and fields don't have empty class attributes or repeated error classes
  (thanks collimarco)
* FIX: Radio buttons don't have the `label="false"` on them when `label:
  false` is set (PR #107 thanks frenkel)

## Version 1.0.0

* Released Feb 03rd 2015
* Added configuration option to set button class in an initializer
* Updated to be compatible with Foundation 5.2.2
* Bugfixes

## Version 0.5.0

* Released Oct 10th 2014
* Bugfixes

## Version 0.4

* Not released
* Compatibility with Rails 4
* Bugfixes

## Version 0.3

* Not released
* Mostly bugfixes

## Version 0.2.1

* First production release  (Jan 14th, 2012)

## Version 0.1.rc

* initial release candidate (Jan 14th, 2012)
