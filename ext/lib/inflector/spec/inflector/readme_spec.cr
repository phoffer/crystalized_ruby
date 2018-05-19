require "../spec_helper"

Inflector.camelize("active_model")                    # => "ActiveModel"
Inflector.camelize("active_model", false)             # => "activeModel"
Inflector.camelize("active_model/errors")             # => "ActiveModel::Errors"
Inflector.camelize("active_model/errors", false)      # => "activeModel::Errors"

Inflector.underscore("ActiveModel")                   # => "active_model"
Inflector.underscore("ActiveModel::Errors")           # => "active_model/errors"
Inflector.underscore("HTTP::Errors")                  # => "http/errors"

Inflector.humanize("employee_salary")                 # => "Employee salary"
Inflector.humanize("author_id")                       # => "Author"
Inflector.humanize("author_id", capitalize: false)    # => "author"
Inflector.humanize("_id")                             # => "Id"

Inflector.upcase_first("what a Lovely Day")           # => "What a Lovely Day"
Inflector.upcase_first("w")                           # => "W"
Inflector.upcase_first("")                            # => ""

Inflector.titleize("man from the boondocks")          # => "Man From The Boondocks"
Inflector.titleize("x-men: the last stand")           # => "X Men: The Last Stand"
Inflector.titleize("TheManWithoutAPast")              # => "The Man Without A Past"
Inflector.titleize("raiders_of_the_lost_ark")         # => "Raiders Of The Lost Ark"

Inflector.classify("ham_and_eggs")                    # => "HamAndEgg"
Inflector.classify("posts")                           # => "Post"

Inflector.dasherize("puni_puni")                      # => "puni-puni"

Inflector.demodulize("CoreExt::String::Inflections")  # => "Inflections"
Inflector.demodulize("Inflections")                   # => "Inflections"
Inflector.demodulize("::Inflections")                 # => "Inflections"
Inflector.demodulize("")                              # => ""

Inflector.deconstantize("Net::HTTP")                  # => "Net"
Inflector.deconstantize("::Net::HTTP")                # => "::Net"
Inflector.deconstantize("String")                     # => ""
Inflector.deconstantize("::String")                   # => ""
Inflector.deconstantize("")                           # => ""

Inflector.foreign_key("Message")                      # => "message_id"
Inflector.foreign_key("Message", false)               # => "messageid"
Inflector.foreign_key("Admin::Post")                  # => "post_id"

Inflector.ordinal(1)                                  # => "st"
Inflector.ordinal(2)                                  # => "nd"
Inflector.ordinal(1002)                               # => "nd"
Inflector.ordinal(1003)                               # => "rd"
Inflector.ordinal(-11)                                # => "th"
Inflector.ordinal(-1021)                              # => "st"

Inflector.ordinalize(1)                               # => "1st"
Inflector.ordinalize(2)                               # => "2nd"
Inflector.ordinalize(1002)                            # => "1002nd"
Inflector.ordinalize(1003)                            # => "1003rd"
Inflector.ordinalize(-11)                             # => "-11th"
Inflector.ordinalize(-1021)                           # => "-1021st"