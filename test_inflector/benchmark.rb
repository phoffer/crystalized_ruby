require "./inflector"

require 'benchmark/ips'
require 'active_support/all'



Benchmark.ips do |x|
  x.report('cr ordinal') do
    1.cr_ordinal               # => "st"
    2.cr_ordinal               # => "nd"
    1002.cr_ordinal            # => "nd"
    1003.cr_ordinal            # => "rd"
    -11.cr_ordinal             # => "th"
    -1001.cr_ordinal           # => "st"
  end
  x.report('AS ordinal') do
    1.ordinal               # => "st"
    2.ordinal               # => "nd"
    1002.ordinal            # => "nd"
    1003.ordinal            # => "rd"
    -11.ordinal             # => "th"
    -1001.ordinal           # => "st"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr ordinalize') do
    1.cr_ordinalize            # => "1st"
    2.cr_ordinalize            # => "2nd"
    1002.cr_ordinalize         # => "1002nd"
    1003.cr_ordinalize         # => "1003rd"
    -11.cr_ordinalize          # => "-11th"
    -1001.cr_ordinalize        # => "-1001st"
  end
  x.report('AS ordinalize') do
    1.ordinalize            # => "1st"
    2.ordinalize            # => "2nd"
    1002.ordinalize         # => "1002nd"
    1003.ordinalize         # => "1003rd"
    -11.ordinalize          # => "-11th"
    -1001.ordinalize        # => "-1001st"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr blank?') do
    ''.cr_blank?                                                      # => true
    '   '.cr_blank?                                                   # => true
    "\t\n\r".cr_blank?                                                # => true
    ' blah '.cr_blank?                                                # => false
    "\u00a0".cr_blank?                                                # => true
  end
  x.report('AS blank?') do
    ''.blank?                                                      # => true
    '   '.blank?                                                   # => true
    "\t\n\r".blank?                                                # => true
    ' blah '.blank?                                                # => false
    "\u00a0".blank?                                                # => true
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr squish') do
    " foo   bar    \n   \t   boo".cr_squish                           # => "foo bar boo"
  end
  x.report('AS squish') do
    " foo   bar    \n   \t   boo".squish                           # => "foo bar boo"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr pluralize') do
    "post".cr_pluralize                                               # => "posts"
    "octopus".cr_pluralize                                            # => "octopi"
    "sheep".cr_pluralize                                              # => "sheep"
    "words".cr_pluralize                                              # => "words"
    "the blue mailman".cr_pluralize                                   # => "the blue mailmen"
    "CamelOctopus".cr_pluralize                                       # => "CamelOctopi"
    "apple".cr_pluralize                                              # => "apples"
    "apples".cr_pluralize                                             # => "apples"
  end
  x.report('AS pluralize') do
    "post".pluralize                                               # => "posts"
    "octopus".pluralize                                            # => "octopi"
    "sheep".pluralize                                              # => "sheep"
    "words".pluralize                                              # => "words"
    "the blue mailman".pluralize                                   # => "the blue mailmen"
    "CamelOctopus".pluralize                                       # => "CamelOctopi"
    "apple".pluralize                                              # => "apples"
    "apples".pluralize                                             # => "apples"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr singularize') do
    "apple".cr_singularize                                            # => "apple"
    "apples".cr_singularize                                           # => "apple"
    "posts".cr_singularize                                            # => "post"
    "octopi".cr_singularize                                           # => "octopus"
    "sheep".cr_singularize                                            # => "sheep"
    "word".cr_singularize                                             # => "word"
    "the blue mailmen".cr_singularize                                 # => "the blue mailman"
    "CamelOctopi".cr_singularize                                      # => "CamelOctopus"
  end
  x.report('AS singularize') do
    "apple".singularize                                            # => "apple"
    "apples".singularize                                           # => "apple"
    "posts".singularize                                            # => "post"
    "octopi".singularize                                           # => "octopus"
    "sheep".singularize                                            # => "sheep"
    "word".singularize                                             # => "word"
    "the blue mailmen".singularize                                 # => "the blue mailman"
    "CamelOctopi".singularize                                      # => "CamelOctopus"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr camelize') do
    "active_record".cr_camelize                                       # => "ActiveRecord"
    "active_record".cr_camelize                                       # => "activeRecord"
    "active_record/errors".cr_camelize                                # => "ActiveRecord::Errors"
    "active_record/errors".cr_camelize                                # => "activeRecord::Errors"
  end
  x.report('AS camelize') do
    "active_record".camelize                                       # => "ActiveRecord"
    "active_record".camelize                                       # => "activeRecord"
    "active_record/errors".camelize                                # => "ActiveRecord::Errors"
    "active_record/errors".camelize                                # => "activeRecord::Errors"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr titleize') do
    "man from the boondocks".cr_titleize                              # => "Man From The Boondocks"
    "x-men: the last stand".cr_titleize                               # => "X Men: The Last Stand"
  end
  x.report('AS titleize') do
    "man from the boondocks".titleize                              # => "Man From The Boondocks"
    "x-men: the last stand".titleize                               # => "X Men: The Last Stand"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr as_underscore') do
    "ActiveModel".cr_as_underscore                                    # => "active_model"
    # "ActiveModel".cr_underscore                                     # => "active_model" # native crystal implementation doesn't handle custom things like ::
    "ActiveModel::Errors".cr_as_underscore                            # => "active_model/errors"
    # "ActiveModel::Errors".cr_underscore                             # => "active_model/errors" # native crystal implementation doesn't handle custom things like ::
  end
  x.report('AS as_underscore') do
    "ActiveModel".underscore                                    # => "active_model"
    # "ActiveModel".underscore                                     # => "active_model" # native crystal implementation doesn't handle custom things like ::
    "ActiveModel::Errors".underscore                            # => "active_model/errors"
    # "ActiveModel::Errors".underscore                             # => "active_model/errors" # native crystal implementation doesn't handle custom things like ::
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr dasherize') do
    "puni_puni".cr_dasherize                                          # => "puni-puni"
  end
  x.report('AS dasherize') do
    "puni_puni".dasherize                                          # => "puni-puni"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr demodulize') do
    "ActiveRecord::CoreExtensions::String::Inflections".cr_demodulize # => "Inflections"
    "Inflections".cr_demodulize                                       # => "Inflections"
    "::Inflections".cr_demodulize                                     # => "Inflections"
    "".cr_demodulize                                                  # => ""
  end
  x.report('AS demodulize') do
    "ActiveRecord::CoreExtensions::String::Inflections".demodulize # => "Inflections"
    "Inflections".demodulize                                       # => "Inflections"
    "::Inflections".demodulize                                     # => "Inflections"
    "".demodulize                                                  # => ""
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr deconstantize') do
    "Net::HTTP".cr_deconstantize                                      # => "Net"
    "::Net::HTTP".cr_deconstantize                                    # => "::Net"
    "String".cr_deconstantize                                         # => ""
    "::String".cr_deconstantize                                       # => ""
    "".cr_deconstantize                                               # => ""
  end
  x.report('AS deconstantize') do
    "Net::HTTP".deconstantize                                      # => "Net"
    "::Net::HTTP".deconstantize                                    # => "::Net"
    "String".deconstantize                                         # => ""
    "::String".deconstantize                                       # => ""
    "".deconstantize                                               # => ""
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr tableize') do
    "RawScaledScorer".cr_tableize                                     # => "raw_scaled_scorers"
    "ham_and_egg".cr_tableize                                         # => "ham_and_eggs"
    "fancyCategory".cr_tableize                                       # => "fancy_categories"
  end
  x.report('AS tableize') do
    "RawScaledScorer".tableize                                     # => "raw_scaled_scorers"
    "ham_and_egg".tableize                                         # => "ham_and_eggs"
    "fancyCategory".tableize                                       # => "fancy_categories"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr classify') do
    "ham_and_eggs".cr_classify                                        # => "HamAndEgg"
    "posts".cr_classify                                               # => "Post"
  end
  x.report('AS classify') do
    "ham_and_eggs".classify                                        # => "HamAndEgg"
    "posts".classify                                               # => "Post"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr humanize') do
    "employee_salary".cr_humanize                                     # => "Employee salary"
    "author_id".cr_humanize                                           # => "Author"
    "author_id".cr_humanize                                           # => "author"
    "_id".cr_humanize                                                 # => "Id"
  end
  x.report('AS humanize') do
    "employee_salary".humanize                                     # => "Employee salary"
    "author_id".humanize                                           # => "Author"
    "author_id".humanize                                           # => "author"
    "_id".humanize                                                 # => "Id"
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr upcase_first') do
    "what a Lovely Day".cr_upcase_first                               # => "What a Lovely Day"
    "w".cr_upcase_first                                               # => "W"
    "".cr_upcase_first                                                # => ""
  end
  x.report('AS upcase_first') do
    "what a Lovely Day".upcase_first                               # => "What a Lovely Day"
    "w".upcase_first                                               # => "W"
    "".upcase_first                                                # => ""
  end
  x.compare!
end

Benchmark.ips do |x|
  x.report('cr foreign_key') do
    "Message".cr_foreign_key                                          # => "message_id"
    "Message".cr_foreign_key                                          # => "messageid"
    "Admin::Post".cr_foreign_key                                      # => "post_id"
  end
  x.report('AS foreign_key') do
    "Message".foreign_key                                          # => "message_id"
    "Message".foreign_key                                          # => "messageid"
    "Admin::Post".foreign_key                                      # => "post_id"
  end
  x.compare!
end

require 'fast_blank'
Benchmark.ips do |x|
  x.report('cr blank?') do
    ''.cr_blank?                                                      # => true
    '   '.cr_blank?                                                   # => true
    "\t\n\r".cr_blank?                                                # => true
    ' blah '.cr_blank?                                                # => false
    "\u00a0".cr_blank?                                                # => true
  end
  x.report('fast blank?') do
    ''.blank?                                                      # => true
    '   '.blank?                                                   # => true
    "\t\n\r".blank?                                                # => true
    ' blah '.blank?                                                # => false
    "\u00a0".blank?                                                # => true
  end
  x.compare!
end
