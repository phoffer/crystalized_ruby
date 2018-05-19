require "./inflections"

# The Inflector transforms words from singular to plural, class names to table
# names, modularized class names to ones without, and class names to foreign
# keys. The default inflections for pluralization, singularization, and
# uncountable words are kept in inflections.rb.
#
# The Rails core team has stated patches for the inflections library will not
# be accepted in order to avoid breaking legacy applications which may be
# relying on errant inflections. If you discover an incorrect inflection and
# require it for your application or wish to define rules for languages other
# than English, please correct or add them yourself (explained below).
module Inflector
  extend self

  # Returns the plural form of the word in the string.
  #
  # If passed an optional +locale+ parameter, the word will be
  # pluralized using rules defined for that language. By default,
  # this parameter is set to <tt>:en</tt>.
  #
  #   pluralize("post")             # => "posts"
  #   pluralize("octopus")          # => "octopi"
  #   pluralize("sheep")            # => "sheep"
  #   pluralize("words")            # => "words"
  #   pluralize("CamelOctopus")     # => "CamelOctopi"
  #   pluralize("ley", :es)         # => "leyes"
  def pluralize(word, locale = :en)
    apply_inflections(word, inflections(locale).plurals)
  end

  # The reverse of #pluralize, returns the singular form of a word in a
  # string.
  #
  # If passed an optional +locale+ parameter, the word will be
  # singularized using rules defined for that language. By default,
  # this parameter is set to <tt>:en</tt>.
  #
  #   singularize('posts')            # => "post"
  #   singularize('octopi')           # => "octopus"
  #   singularize('sheep')            # => "sheep"
  #   singularize('word')             # => "word"
  #   singularize('CamelOctopi')      # => "CamelOctopus"
  #   singularize('leyes', :es)       # => "ley"
  def singularize(word, locale = :en)
    apply_inflections(word, inflections(locale).singulars)
  end

  # Converts strings to UpperCamelCase.
  # If the +uppercase_first_letter+ parameter is set to false, then produces
  # lowerCamelCase.
  #
  # Also converts "/" to "::" which is useful for converting
  # paths to namespaces.
  #
  #   camelize("active_model")                # => "ActiveModel"
  #   camelize("active_model", false)         # => "activeModel"
  #   camelize("active_model/errors")         # => "ActiveModel::Errors"
  #   camelize("active_model/errors", false)  # => "activeModel::Errors"
  #
  # As a rule of thumb you can think of +camelize+ as the inverse of
  # #underscore, though there are cases where that does not hold:
  #
  #   camelize(underscore("SSLError"))        # => "SslError"
  def camelize(term, uppercase_first_letter = true)
    string = term.to_s
    if uppercase_first_letter
      string = string.gsub(/^[a-z\d]*/) { |s| inflections.acronyms[s]? || s.capitalize }
    else
      string = string.gsub(/^(?:#{inflections.acronym_regex}(?=\b|[A-Z_])|\w)/) { |s| s.downcase }
    end
    string
      .gsub(/(?:_|(\/))([a-z\d]*)/i) { |s, m| "#{m[1]?}#{inflections.acronyms[m[2]]? || m[2].capitalize}" }
      .gsub("/", "::")
  end

  # Makes an underscored, lowercase form from the expression in the string.
  #
  # Changes "::" to "/" to convert namespaces to paths.
  #
  #   underscore("ActiveModel")         # => "active_model"
  #   underscore("ActiveModel::Errors") # => "active_model/errors"
  #
  # As a rule of thumb you can think of +underscore+ as the inverse of
  # #camelize, though there are cases where that does not hold:
  #
  #   camelize(underscore("SSLError"))  # => "SslError"
  def underscore(camel_cased_word)
    return camel_cased_word unless camel_cased_word =~ /[A-Z-]|::/

    camel_cased_word
      .gsub("::", "/")
      .gsub(/(?:(?<=([A-Za-z\d]))|\b)(#{inflections.acronym_regex})(?=\b|[^a-z])/) { |s, m| "#{m[1]? && "_"}#{m[2].downcase}" }
      .gsub(/([A-Z\d]+)([A-Z][a-z])/) { |s, m| "#{m[1]}_#{m[2]}" }
      .gsub(/([a-z\d])([A-Z])/) { |s, m| "#{m[1]}_#{m[2]}" }
      .tr("-", "_")
      .downcase
  end

  # Tweaks an attribute name for display to end users.
  #
  # Specifically, performs these transformations:
  #
  # * Applies human inflection rules to the argument.
  # * Deletes leading underscores, if any.
  # * Removes a "_id" suffix if present.
  # * Replaces underscores with spaces, if any.
  # * Downcases all words except acronyms.
  # * Capitalizes the first word.
  #
  # The capitalization of the first word can be turned off by setting the
  # +:capitalize+ option to false (default is true).
  #
  #   humanize("employee_salary")              # => "Employee salary"
  #   humanize("author_id")                    # => "Author"
  #   humanize("author_id", capitalize: false) # => "author"
  #   humanize("_id")                          # => "Id"
  #
  # If "SSL" was defined to be an acronym:
  #
  #   humanize("ssl_error") # => "SSL error"
  #
  def humanize(lower_case_and_underscored_word, capitalize = true)
    result = lower_case_and_underscored_word.to_s

    inflections.humans.find do |rule_and_replacement|
      rule, replacement = rule_and_replacement
      if result[rule]?
        result = result.gsub(rule, replacement)
      end
    end

    result = result.gsub(/\A_+/, "").gsub(/_id\z/, "").tr("_", " ")

    result = result.gsub(/([a-z\d]*)/i) do |match|
      inflections.acronyms.fetch(match, match.downcase)
    end

    if capitalize
      result = result.sub(/\A\w/) { |match| match.upcase }
    end

    result
  end

  # Converts just the first character to uppercase.
  #
  #   upcase_first("what a Lovely Day") # => "What a Lovely Day"
  #   upcase_first("w")                 # => "W"
  #   upcase_first("")                  # => ""
  def upcase_first(string : String)
    string.size > 0 ? string[1..-1].insert(0, string[0].upcase) : ""
  end
  def upcase_first(char : Char)
    char.upcase
  end

  # Capitalizes all the words and replaces some characters in the string to
  # create a nicer looking title. +titleize+ is meant for creating pretty
  # output. It is not used in the Rails internals.
  #
  # +titleize+ is also aliased as +titlecase+.
  #
  #   titleize('man from the boondocks')   # => "Man From The Boondocks"
  #   titleize('x-men: the last stand')    # => "X Men: The Last Stand"
  #   titleize('TheManWithoutAPast')       # => "The Man Without A Past"
  #   titleize('raiders_of_the_lost_ark')  # => "Raiders Of The Lost Ark"
  def titleize(word)
    humanize(underscore(word)).gsub(/\b(?<!['’`])[a-z]/) { |match| match.capitalize }
  end

  # Creates the name of a table like Rails does for models to table names.
  # This method uses the #pluralize method on the last word in the string.
  #
  #   tableize('RawScaledScorer') # => "raw_scaled_scorers"
  #   tableize('egg_and_ham')     # => "egg_and_hams"
  #   tableize('fancyCategory')   # => "fancy_categories"
  def tableize(class_name)
    pluralize(underscore(class_name))
  end

  # Creates a class name from a plural table name like Rails does for table
  # names to models. Note that this returns a string and not a Class (To
  # convert to an actual class follow +classify+ with #constantize).
  #
  #   classify("egg_and_hams") # => "EggAndHam"
  #   classify("posts")        # => "Post"
  #
  # Singular names are not handled correctly:
  #
  #   classify("calculus")     # => "Calculu"
  def classify(table_name : String)
    camelize(singularize(table_name.sub(/.*\./, "")))
  end
  def classify(table_name : Symbol)
    camelize(singularize(table_name.to_s.sub(/.*\./, "")))
  end

  # Replaces underscores with dashes in the string.
  #
  #   dasherize("puni_puni") # => "puni-puni"
  def dasherize(underscored_word)
    underscored_word.tr("_", "-")
  end

  # Removes the module part from the expression in the string.
  #
  #   demodulize("ActiveRecord::CoreExtensions::String::Inflections") # => "Inflections"
  #   demodulize("Inflections")                                       # => "Inflections"
  #   demodulize("::Inflections")                                     # => "Inflections"
  #   demodulize("")                                                  # => ""
  #
  # See also #deconstantize.
  def demodulize(path)
    path = path.to_s
    if i = path.rindex("::")
      path[(i+2)..-1]
    else
      path
    end
  end

  # Removes the rightmost segment from the constant expression in the string.
  #
  #   deconstantize("Net::HTTP")   # => "Net"
  #   deconstantize("::Net::HTTP") # => "::Net"
  #   deconstantize("String")      # => ""
  #   deconstantize("::String")    # => ""
  #   deconstantize("")            # => ""
  #
  # See also #demodulize.
  def deconstantize(path)
    path.to_s[0, path.rindex("::") || 0] # implementation based on the one in facets" Module#spacename
  end

  # Creates a foreign key name from a class name.
  # +separate_class_name_and_id_with_underscore+ sets whether
  # the method should put "_" between the name and "id".
  #
  #   foreign_key("Message")        # => "message_id"
  #   foreign_key("Message", false) # => "messageid"
  #   foreign_key("Admin::Post")    # => "post_id"
  def foreign_key(class_name, separate_class_name_and_id_with_underscore = true)
    underscore(demodulize(class_name)) + (separate_class_name_and_id_with_underscore ? "_id" : "id")
  end

  # Returns the suffix that should be added to a number to denote the position
  # in an ordered sequence such as 1st, 2nd, 3rd, 4th.
  #
  #   ordinal(1)     # => "st"
  #   ordinal(2)     # => "nd"
  #   ordinal(1002)  # => "nd"
  #   ordinal(1003)  # => "rd"
  #   ordinal(-11)   # => "th"
  #   ordinal(-1021) # => "st"
  def ordinal(number)
    abs_number = number.to_i.abs

    if (11..13).includes?(abs_number % 100)
      "th"
    else
      case abs_number % 10
        when 1; "st"
        when 2; "nd"
        when 3; "rd"
        else    "th"
      end
    end
  end

  # Turns a number into an ordinal string used to denote the position in an
  # ordered sequence such as 1st, 2nd, 3rd, 4th.
  #
  #   ordinalize(1)     # => "1st"
  #   ordinalize(2)     # => "2nd"
  #   ordinalize(1002)  # => "1002nd"
  #   ordinalize(1003)  # => "1003rd"
  #   ordinalize(-11)   # => "-11th"
  #   ordinalize(-1021) # => "-1021st"
  def ordinalize(number)
    "#{number}#{ordinal(number)}"
  end

  # Applies inflection rules for +singularize+ and +pluralize+.
  #
  #  apply_inflections("post", inflections.plurals)    # => "posts"
  #  apply_inflections("posts", inflections.singulars) # => "post"
  private def apply_inflections(word, rules)
    result = word.to_s

    return result if result.empty? || inflections.uncountables.includes?(result.downcase[/\b\w+\Z/])

    rules.find do |rule_and_replacement|
      rule, replacement = rule_and_replacement
      if result =~ rule
        result = result.gsub(rule) do |s, match|
          replacement.gsub("\\1", match[1]?).gsub("\\2", match[2]?)
        end
      end
    end
    result
  end
end