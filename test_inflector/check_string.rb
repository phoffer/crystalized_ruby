require "./inflector"


puts 1.cr_ordinalize            # => "1st"
puts 2.cr_ordinalize            # => "2nd"
puts 1002.cr_ordinalize         # => "1002nd"
puts 1003.cr_ordinalize         # => "1003rd"
puts -11.cr_ordinalize          # => "-11th"
puts -1001.cr_ordinalize        # => "-1001st"
puts 1.cr_ordinal               # => "st"
puts 2.cr_ordinal               # => "nd"
puts 1002.cr_ordinal            # => "nd"
puts 1003.cr_ordinal            # => "rd"
puts -11.cr_ordinal             # => "th"
puts -1001.cr_ordinal           # => "st"

puts ''.cr_blank?                                                      # => true
puts '   '.cr_blank?                                                   # => true
puts "\t\n\r".cr_blank?                                                # => true
puts ' blah '.cr_blank?                                                # => false
puts "\u00a0".cr_blank?                                                # => true

puts " foo   bar    \n   \t   boo".cr_squish                           # => "foo bar boo"

puts "post".cr_pluralize                                               # => "posts"
puts "octopus".cr_pluralize                                            # => "octopi"
puts "sheep".cr_pluralize                                              # => "sheep"
puts "words".cr_pluralize                                              # => "words"
puts "the blue mailman".cr_pluralize                                   # => "the blue mailmen"
puts "CamelOctopus".cr_pluralize                                       # => "CamelOctopi"
puts "apple".cr_pluralize                                              # => "apples"
puts "apples".cr_pluralize                                             # => "apples"

puts "apple".cr_singularize                                            # => "apple"
puts "apples".cr_singularize                                           # => "apple"
puts "posts".cr_singularize                                            # => "post"
puts "octopi".cr_singularize                                           # => "octopus"
puts "sheep".cr_singularize                                            # => "sheep"
puts "word".cr_singularize                                             # => "word"
puts "the blue mailmen".cr_singularize                                 # => "the blue mailman"
puts "CamelOctopi".cr_singularize                                      # => "CamelOctopus"

puts "active_record".cr_camelize                                       # => "ActiveRecord"
puts "active_record".cr_camelize                                       # => "activeRecord"
puts "active_record/errors".cr_camelize                                # => "ActiveRecord::Errors"
puts "active_record/errors".cr_camelize                                # => "activeRecord::Errors"

puts "man from the boondocks".cr_titleize                              # => "Man From The Boondocks"
puts "x-men: the last stand".cr_titleize                               # => "X Men: The Last Stand"

puts "ActiveModel".cr_as_underscore                                    # => "active_model"
# puts "ActiveModel".cr_underscore                                     # => "active_model" # native crystal implementation doesn't handle custom things like ::
puts "ActiveModel::Errors".cr_as_underscore                            # => "active_model/errors"
# puts "ActiveModel::Errors".cr_underscore                             # => "active_model/errors" # native crystal implementation doesn't handle custom things like ::

puts "puni_puni".cr_dasherize                                          # => "puni-puni"

puts "ActiveRecord::CoreExtensions::String::Inflections".cr_demodulize # => "Inflections"
puts "Inflections".cr_demodulize                                       # => "Inflections"
puts "::Inflections".cr_demodulize                                     # => "Inflections"
puts "".cr_demodulize                                                  # => ""

puts "Net::HTTP".cr_deconstantize                                      # => "Net"
puts "::Net::HTTP".cr_deconstantize                                    # => "::Net"
puts "String".cr_deconstantize                                         # => ""
puts "::String".cr_deconstantize                                       # => ""
puts "".cr_deconstantize                                               # => ""

puts "RawScaledScorer".cr_tableize                                     # => "raw_scaled_scorers"
puts "ham_and_egg".cr_tableize                                         # => "ham_and_eggs"
puts "fancyCategory".cr_tableize                                       # => "fancy_categories"

puts "ham_and_eggs".cr_classify                                        # => "HamAndEgg"
puts "posts".cr_classify                                               # => "Post"

puts "employee_salary".cr_humanize                                     # => "Employee salary"
puts "author_id".cr_humanize                                           # => "Author"
puts "author_id".cr_humanize                                           # => "author"
puts "_id".cr_humanize                                                 # => "Id"

puts "what a Lovely Day".cr_upcase_first                               # => "What a Lovely Day"
puts "w".cr_upcase_first                                               # => "W"
puts "".cr_upcase_first                                                # => ""

puts "Message".cr_foreign_key                                          # => "message_id"
puts "Message".cr_foreign_key                                          # => "messageid"
puts "Admin::Post".cr_foreign_key                                      # => "post_id"