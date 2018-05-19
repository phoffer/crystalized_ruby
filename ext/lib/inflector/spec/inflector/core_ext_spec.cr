require "../spec_helper"
require "../../src/core_ext"

describe "core extensions" do
  describe "blank?" do
    assert { "#{0xa0.chr}".blank?.should be_true }
    assert { "\t\n".blank?.should be_true }
    assert { " ".blank?.should be_true }
    assert { "a".blank?.should be_false }
    assert { "a ".blank?.should be_false }
    assert { "".blank?.should be_true }
  end
end


1.ordinalize                                # => "1st"
2.ordinalize                                # => "2nd"
1002.ordinalize                             # => "1002nd"
1003.ordinalize                             # => "1003rd"
-11.ordinalize                              # => "-11th"
-1001.ordinalize                            # => "-1001st"
1.ordinal                                   # => "st"
2.ordinal                                   # => "nd"
1002.ordinal                                # => "nd"
1003.ordinal                                # => "rd"
-11.ordinal                                 # => "th"
-1001.ordinal                               # => "st"

"post".pluralize                            # => "posts"
"octopus".pluralize                         # => "octopi"
"sheep".pluralize                           # => "sheep"
"words".pluralize                           # => "words"
"the blue mailman".pluralize                # => "the blue mailmen"
"CamelOctopus".pluralize                    # => "CamelOctopi"
"apple".pluralize(1)                        # => "apple"

"posts".singularize                         # => "post"
"octopi".singularize                        # => "octopus"
"sheep".singularize                         # => "sheep"
"word".singularize                          # => "word"
"the blue mailmen".singularize              # => "the blue mailman"
"CamelOctopi".singularize                   # => "CamelOctopus"

"active_record".camelize                    # => "ActiveRecord"
"active_record".camelize(:lower)            # => "activeRecord"
"active_record/errors".camelize             # => "ActiveRecord::Errors"
"active_record/errors".camelize(:lower)     # => "activeRecord::Errors"

"man from the boondocks".titleize           # => "Man From The Boondocks"
"x-men: the last stand".titleize            # => "X Men: The Last Stand"

"ActiveModel".as_underscore                 # => "active_model"
"ActiveModel::Errors".as_underscore         # => "active_model/errors"

"puni_puni".dasherize                       # => "puni-puni"

"CoreExt::String::Inflections".demodulize   # => "Inflections"
"Inflections".demodulize                    # => "Inflections"
"::Inflections".demodulize                  # => "Inflections"
"".demodulize                               # => ""

"Net::HTTP".deconstantize                   # => "Net"
"::Net::HTTP".deconstantize                 # => "::Net"
"String".deconstantize                      # => ""
"::String".deconstantize                    # => ""
"".deconstantize                            # => ""

"RawScaledScorer".tableize                  # => "raw_scaled_scorers"
"ham_and_egg".tableize                      # => "ham_and_eggs"
"fancyCategory".tableize                    # => "fancy_categories"

"ham_and_eggs".classify                     # => "HamAndEgg"
"posts".classify                            # => "Post"

"employee_salary".humanize                  # => "Employee salary"
"author_id".humanize                        # => "Author"
"author_id".humanize(capitalize: false)     # => "author"
"_id".humanize                              # => "Id"

"what a Lovely Day".upcase_first            # => "What a Lovely Day"
"w".upcase_first                            # => "W"
"".upcase_first                             # => ""

"Message".foreign_key                       # => "message_id"
"Message".foreign_key(false)                # => "messageid"
"Admin::Post".foreign_key                   # => "post_id"
