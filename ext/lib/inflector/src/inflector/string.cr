require "./methods"


struct Char
  def blank?
    case ord
    when 9, 0xa, 0xb, 0xc, 0xd, 0x20, 0x85, 0xa0, 0x1680, 0x180e,
          0x2000, 0x2001, 0x2002, 0x2003, 0x2004, 0x2005, 0x2006,
          0x2007, 0x2008, 0x2009, 0x200a, 0x2028, 0x2029, 0x202f,
          0x205f, 0x3000 then true
    else
      false
    end
  end
end
class String

  # A string is blank if it's empty or contains whitespaces only:
  #
  #   ''.blank?       # => true
  #   '   '.blank?    # => true
  #   "\t\n\r".blank? # => true
  #   ' blah '.blank? # => false
  #
  # Unicode whitespace is supported:
  #
  #   "\u00a0".blank? # => true
  #
  # @return [true, false]
  def blank?
    each_char.all? &.blank?
  end

  # Performs a destructive squish. See String#squish.
  #   str = " foo   bar    \n   \t   boo"
  #   str.squish!                         # => "foo bar boo"
  #   str                                 # => "foo bar boo"
  SQUISH_REGEX = /[[:space:]]+/
  def squish
    self.gsub(SQUISH_REGEX, ' ').strip
  end

  # Returns the plural form of the word in the string.
  #
  # If the optional parameter +count+ is specified,
  # the singular form will be returned if <tt>count == 1</tt>.
  # For any other value of +count+ the plural will be returned.
  #
  # If the optional parameter +locale+ is specified,
  # the word will be pluralized as a word of that language.
  # By default, this parameter is set to <tt>:en</tt>.
  # You must define your own inflection rules for languages other than English.
  #
  #   'post'.pluralize             # => "posts"
  #   'octopus'.pluralize          # => "octopi"
  #   'sheep'.pluralize            # => "sheep"
  #   'words'.pluralize            # => "words"
  #   'the blue mailman'.pluralize # => "the blue mailmen"
  #   'CamelOctopus'.pluralize     # => "CamelOctopi"
  #   'apple'.pluralize(1)         # => "apple"
  #   'apple'.pluralize(2)         # => "apples"
  #   'ley'.pluralize(:es)         # => "leyes"
  #   'ley'.pluralize(1, :es)      # => "ley"
  def pluralize(count = nil, locale = :en)
    locale = count if count.is_a?(Symbol)
    if count == 1
      self.dup
    else
      Inflector.pluralize(self, locale)
    end
  end

  # The reverse of +pluralize+, returns the singular form of a word in a string.
  #
  # If the optional parameter +locale+ is specified,
  # the word will be singularized as a word of that language.
  # By default, this parameter is set to <tt>:en</tt>.
  # You must define your own inflection rules for languages other than English.
  #
  #   'posts'.singularize            # => "post"
  #   'octopi'.singularize           # => "octopus"
  #   'sheep'.singularize            # => "sheep"
  #   'word'.singularize             # => "word"
  #   'the blue mailmen'.singularize # => "the blue mailman"
  #   'CamelOctopi'.singularize      # => "CamelOctopus"
  #   'leyes'.singularize(:es)       # => "ley"
  def singularize(locale = :en)
    Inflector.singularize(self, locale)
  end

  # +constantize+ tries to find a declared constant with the name specified
  # in the string. It raises a NameError when the name is not in CamelCase
  # or is not initialized.  See Inflector.constantize
  #
  #   'Module'.constantize  # => Module
  #   'Class'.constantize   # => Class
  #   'blargle'.constantize # => NameError: wrong constant name blargle
############
# not dealing with ruby classes
############
  # def constantize
  #   Inflector.constantize(self)
  # end

  # +safe_constantize+ tries to find a declared constant with the name specified
  # in the string. It returns nil when the name is not in CamelCase
  # or is not initialized.  See Inflector.safe_constantize
  #
  #   'Module'.safe_constantize  # => Module
  #   'Class'.safe_constantize   # => Class
  #   'blargle'.safe_constantize # => nil
############
# not dealing with ruby classes
############
  # def safe_constantize
  #   Inflector.safe_constantize(self)
  # end

  # By default, +camelize+ converts strings to UpperCamelCase. If the argument to camelize
  # is set to <tt>:lower</tt> then camelize produces lowerCamelCase.
  #
  # +camelize+ will also convert '/' to '::' which is useful for converting paths to namespaces.
  #
  #   'active_record'.camelize                # => "ActiveRecord"
  #   'active_record'.camelize(:lower)        # => "activeRecord"
  #   'active_record/errors'.camelize         # => "ActiveRecord::Errors"
  #   'active_record/errors'.camelize(:lower) # => "activeRecord::Errors"
  def camelize(first_letter = :upper)
    case first_letter
    when :upper
      Inflector.camelize(self, true)
    when :lower
      Inflector.camelize(self, false)
    end
  end
  # Don't want to redefine native method
  # def camelcase(first_letter = :upper)
  #   camelize(first_letter)
  # end

  # Capitalizes all the words and replaces some characters in the string to create
  # a nicer looking title. +titleize+ is meant for creating pretty output. It is not
  # used in the Rails internals.
  #
  # +titleize+ is also aliased as +titlecase+.
  #
  #   'man from the boondocks'.titleize # => "Man From The Boondocks"
  #   'x-men: the last stand'.titleize  # => "X Men: The Last Stand"
  def titleize
    Inflector.titleize(self)
  end
  def titlecase
    titleize
  end

  # The reverse of +camelize+. Makes an underscored, lowercase form from the expression in the string.
  #
  # +underscore+ will also change '::' to '/' to convert namespaces to paths.
  #
  #   'ActiveModel'.underscore         # => "active_model"
  #   'ActiveModel::Errors'.underscore # => "active_model/errors"
  def as_underscore
    Inflector.underscore(self)
  end

  # Replaces underscores with dashes in the string.
  #
  #   'puni_puni'.dasherize # => "puni-puni"
  def dasherize
    Inflector.dasherize(self)
  end

  # Removes the module part from the constant expression in the string.
  #
  #   'ActiveRecord::CoreExtensions::String::Inflections'.demodulize # => "Inflections"
  #   'Inflections'.demodulize                                       # => "Inflections"
  #   '::Inflections'.demodulize                                     # => "Inflections"
  #   ''.demodulize                                                  # => ""
  #
  # See also +deconstantize+.
  def demodulize
    Inflector.demodulize(self)
  end

  # Removes the rightmost segment from the constant expression in the string.
  #
  #   'Net::HTTP'.deconstantize   # => "Net"
  #   '::Net::HTTP'.deconstantize # => "::Net"
  #   'String'.deconstantize      # => ""
  #   '::String'.deconstantize    # => ""
  #   ''.deconstantize            # => ""
  #
  # See also +demodulize+.
  def deconstantize
    Inflector.deconstantize(self)
  end

  # Replaces special characters in a string so that it may be used as part of a 'pretty' URL.
  #
  #   class Person
  #     def to_param
  #       "#{id}-#{name.parameterize}"
  #     end
  #   end
  #
  #   @person = Person.find(1)
  #   # => #<Person id: 1, name: "Donald E. Knuth">
  #
  #   <%= link_to(@person.name, person_path) %>
  #   # => <a href="/person/1-donald-e-knuth">Donald E. Knuth</a>
  #   
  # To preserve the case of the characters in a string, use the `preserve_case` argument.
  #
  #   class Person
  #     def to_param
  #       "#{id}-#{name.parameterize(preserve_case: true)}"
  #     end
  #   end
  #
  #   @person = Person.find(1)
  #   # => #<Person id: 1, name: "Donald E. Knuth">
  #
  #   <%= link_to(@person.name, person_path) %>
  #   # => <a href="/person/1-Donald-E-Knuth">Donald E. Knuth</a>
############
# requires transliterate and I'm not dealing with that for now
############  
  # def parameterize(sep = :unused, separator: '-', preserve_case: false)
  #   Inflector.parameterize(self, separator: separator, preserve_case: preserve_case)
  # end

  # Creates the name of a table like Rails does for models to table names. This method
  # uses the +pluralize+ method on the last word in the string.
  #
  #   'RawScaledScorer'.tableize # => "raw_scaled_scorers"
  #   'ham_and_egg'.tableize     # => "ham_and_eggs"
  #   'fancyCategory'.tableize   # => "fancy_categories"
  def tableize
    Inflector.tableize(self)
  end

  # Creates a class name from a plural table name like Rails does for table names to models.
  # Note that this returns a string and not a class. (To convert to an actual class
  # follow +classify+ with +constantize+.)
  #
  #   'ham_and_eggs'.classify # => "HamAndEgg"
  #   'posts'.classify        # => "Post"
  def classify
    Inflector.classify(self)
  end

  # Capitalizes the first word, turns underscores into spaces, and strips a
  # trailing '_id' if present.
  # Like +titleize+, this is meant for creating pretty output.
  #
  # The capitalization of the first word can be turned off by setting the
  # optional parameter +capitalize+ to false.
  # By default, this parameter is true.
  #
  #   'employee_salary'.humanize              # => "Employee salary"
  #   'author_id'.humanize                    # => "Author"
  #   'author_id'.humanize(capitalize: false) # => "author"
  #   '_id'.humanize                          # => "Id"
  def humanize(capitalize = true)
    Inflector.humanize(self, capitalize)
  end

  # Converts just the first character to uppercase.
  #
  #   'what a Lovely Day'.upcase_first # => "What a Lovely Day"
  #   'w'.upcase_first                 # => "W"
  #   ''.upcase_first                  # => ""
  def upcase_first
    Inflector.upcase_first(self)
  end

  # Creates a foreign key name from a class name.
  # +separate_class_name_and_id_with_underscore+ sets whether
  # the method should put '_' between the name and 'id'.
  #
  #   'Message'.foreign_key        # => "message_id"
  #   'Message'.foreign_key(false) # => "messageid"
  #   'Admin::Post'.foreign_key    # => "post_id"
  def foreign_key(separate_class_name_and_id_with_underscore = true)
    Inflector.foreign_key(self, separate_class_name_and_id_with_underscore)
  end
end
