# Inflector (port of ActiveSupport::Inflector) [![Build Status](https://travis-ci.org/phoffer/inflector.cr.svg?branch=master)](https://travis-ci.org/phoffer/inflector.cr)

This is an attempt to bring [ActiveSupport's Inflector](https://github.com/rails/rails/tree/master/activesupport/lib/active_support/inflector) to Crystal. It started as a test idea for another project ([Native Ruby extensions in Crystal](https://github.com/phoffer/crystalized_ruby/)), but then worked well enough that I decided to turn it into its own project.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  inflector:
    github: phoffer/inflector.cr
    version: "~> 0.1.3"
```

Somewhere in your app initialization, `require "inflector"`.

Additionally, there are core extensions to `String` and `Int`. If you want these, then `require "inflector/core_ext` instead of the standard `require`.

## Usage

Some examples are probably best. There is a full set of examples in spec/inflector/readme_spec.cr

```crystal
Inflector.camelize("active_model")                    # => "ActiveModel"
Inflector.underscore("ActiveModel")                   # => "active_model"
Inflector.humanize("employee_salary")                 # => "Employee salary"
Inflector.humanize("author_id")                       # => "Author"
Inflector.upcase_first("what a Lovely Day")           # => "What a Lovely Day"
Inflector.titleize("x-men: the last stand")           # => "X Men: The Last Stand"
Inflector.classify("ham_and_eggs")                    # => "HamAndEgg"
Inflector.demodulize("CoreExt::String::Inflections")  # => "Inflections"
Inflector.deconstantize("Net::HTTP")                  # => "Net"
Inflector.foreign_key("Message")                      # => "message_id"
Inflector.ordinalize(1)                               # => "1st"
Inflector.ordinal(1)                                  # => "st"
Inflector.dasherize("puni_puni")                      # => "puni-puni"
```

Additionally, these are available if you required the core extensions. Additional examples are in spec/inflector/core_ext_spec

```crystal
1.ordinalize                                          # => "1st"
1.ordinal                                             # => "st"
"post".pluralize                                      # => "posts"
"octopus".pluralize                                   # => "octopi"
"posts".singularize                                   # => "post"
"active_record".camelize                              # => "ActiveRecord"
"man from the boondocks".titleize                     # => "Man From The Boondocks"
"CoreExt::String::Inflections".demodulize             # => "Inflections"
"Net::HTTP".deconstantize                             # => "Net"
"fancyCategory".tableize                              # => "fancy_categories"
"ham_and_eggs".classify                               # => "HamAndEgg"
"employee_salary".humanize                            # => "Employee salary"
"what a Lovely Day".upcase_first                      # => "What a Lovely Day"
"Message".foreign_key                                 # => "message_id"
```

## TODO

- [ ] Enable additional tests (tests have been mostly ported from ActiveSupport::Inflector)
- [x] Hook up Travis CI

## Contributing

1. Fork it ( https://github.com/phoffer/inflector.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [rails](https://github.com/rails) Rails Core Team is greatly appreciated for what they have built and extensive documentation
- [phoffer](https://github.com/phoffer) Paul Hoffer - creator, maintainer
