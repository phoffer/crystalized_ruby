require "./inflector.cr"

# puts "\n~~~~~~~~ camelize ++++++++++"
# puts ActiveSupport::Inflector.camelize("active_model")                # => "ActiveModel"
# puts ActiveSupport::Inflector.camelize("active_model", false)         # => "activeModel"
# puts ActiveSupport::Inflector.camelize("active_model/errors")         # => "ActiveModel::Errors"
# puts ActiveSupport::Inflector.camelize("active_model/errors", false)  # => "activeModel::Errors"


# puts "\n~~~~~~~~ underscore ++++++++"
# puts ActiveSupport::Inflector.underscore("ActiveModel")         # => "active_model"
# puts ActiveSupport::Inflector.underscore("ActiveModel::Errors") # => "active_model/errors"
# puts ActiveSupport::Inflector.underscore("HTTP::Errors")        # => "http/errors"

# puts "\n~~~~~~~~ humanize ++++++++"
# puts ActiveSupport::Inflector.humanize("employee_salary")              # => "Employee salary"
# puts ActiveSupport::Inflector.humanize("author_id")                    # => "Author"
# puts ActiveSupport::Inflector.humanize("author_id", capitalize: false) # => "author"
# puts ActiveSupport::Inflector.humanize("_id")                          # => "Id"

# puts "\n~~~~~~~~ upcase_first +++++++++"
# puts ActiveSupport::Inflector.upcase_first("what a Lovely Day") # => "What a Lovely Day"
# puts ActiveSupport::Inflector.upcase_first("w")                 # => "W"
# puts ActiveSupport::Inflector.upcase_first("")                  # => ""

# puts "\n~~~~~~~~ titleize ~~~~~~~~~"
# puts ActiveSupport::Inflector.titleize("man from the boondocks")   # => "Man From The Boondocks"
# puts ActiveSupport::Inflector.titleize("x-men: the last stand")    # => "X Men: The Last Stand"
# puts ActiveSupport::Inflector.titleize("TheManWithoutAPast")       # => "The Man Without A Past"
# puts ActiveSupport::Inflector.titleize("raiders_of_the_lost_ark")  # => "Raiders Of The Lost Ark"

# puts "\n~~~~~~~~ classify ~~~~~~~~~"
# puts ActiveSupport::Inflector.classify("ham_and_eggs") # => "HamAndEgg"
# puts ActiveSupport::Inflector.classify("posts")        # => "Post"

# puts "\n~~~~~~~~ dasherize ~~~~~~~~~"
# puts ActiveSupport::Inflector.dasherize("puni_puni") # => "puni-puni"

# puts "\n~~~~~~~~ demodulize ~~~~~~~~~"
# puts ActiveSupport::Inflector.demodulize("ActiveRecord::CoreExtensions::String::Inflections") # => "Inflections"
# puts ActiveSupport::Inflector.demodulize("Inflections")                                       # => "Inflections"
# puts ActiveSupport::Inflector.demodulize("::Inflections")                                     # => "Inflections"
# puts ActiveSupport::Inflector.demodulize("")                                                  # => ""

# puts "\n~~~~~~~~ deconstantize ~~~~~~~~~"
# puts ActiveSupport::Inflector.deconstantize("Net::HTTP")   # => "Net"
# puts ActiveSupport::Inflector.deconstantize("::Net::HTTP") # => "::Net"
# puts ActiveSupport::Inflector.deconstantize("String")      # => ""
# puts ActiveSupport::Inflector.deconstantize("::String")    # => ""
# puts ActiveSupport::Inflector.deconstantize("")            # => ""

# puts "\n~~~~~~~~ foreign_key ~~~~~~~~~"
# puts ActiveSupport::Inflector.foreign_key("Message")        # => "message_id"
# puts ActiveSupport::Inflector.foreign_key("Message", false) # => "messageid"
# puts ActiveSupport::Inflector.foreign_key("Admin::Post")    # => "post_id"

# puts "\n~~~~~~~~ ordinal ~~~~~~~~~"
# puts ActiveSupport::Inflector.ordinal(1)     # => "st"
# puts ActiveSupport::Inflector.ordinal(2)     # => "nd"
# puts ActiveSupport::Inflector.ordinal(1002)  # => "nd"
# puts ActiveSupport::Inflector.ordinal(1003)  # => "rd"
# puts ActiveSupport::Inflector.ordinal(-11)   # => "th"
# puts ActiveSupport::Inflector.ordinal(-1021) # => "st"

# puts "\n~~~~~~~~ ordinalize ~~~~~~~~~"
# puts ActiveSupport::Inflector.ordinalize(1)     # => "1st"
# puts ActiveSupport::Inflector.ordinalize(2)     # => "2nd"
# puts ActiveSupport::Inflector.ordinalize(1002)  # => "1002nd"
# puts ActiveSupport::Inflector.ordinalize(1003)  # => "1003rd"
# puts ActiveSupport::Inflector.ordinalize(-11)   # => "-11th"
# puts ActiveSupport::Inflector.ordinalize(-1021) # => "-1021st"

puts "\n~~~~~~~~ pluralize +++++++++"
puts ActiveSupport::Inflector.pluralize("post")             # => "posts"
puts ActiveSupport::Inflector.pluralize("posts")            # => "posts"
puts ActiveSupport::Inflector.pluralize("octopus")          # => "octopi"
puts ActiveSupport::Inflector.pluralize("sheep")            # => "sheep"
puts ActiveSupport::Inflector.pluralize("words")            # => "words"
puts ActiveSupport::Inflector.pluralize("CamelOctopus")     # => "CamelOctopi"

puts "\n~~~~~~~~ singularize +++++++++"
puts ActiveSupport::Inflector.singularize("posts")            # => "post"
puts ActiveSupport::Inflector.singularize("post")             # => "post"
puts ActiveSupport::Inflector.singularize("octopi")           # => "octopus"
puts ActiveSupport::Inflector.singularize("sheep")            # => "sheep"
puts ActiveSupport::Inflector.singularize("word")             # => "word"
puts ActiveSupport::Inflector.singularize("CamelOctopi")      # => "CamelOctopus"

original = "posts"
puts original.sub(/s$/i, "s")
puts original.sub(/$/, "s")