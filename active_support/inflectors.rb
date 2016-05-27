=begin
rails/activesupport/lib/active_support/inflector.rb

require 'active_support/inflector/inflections'
require 'active_support/inflector/transliterate'
require 'active_support/inflector/methods'

require 'active_support/inflections'
require 'active_support/core_ext/string/inflections'
=end

# this is what gets required for inflector
class Array
  # The human way of thinking about adding stuff to the end of a list is with append.
  alias_method :append,  :<<

  # The human way of thinking about adding stuff to the beginning of a list is with prepend.
  alias_method :prepend, :unshift
end

