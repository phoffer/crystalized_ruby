require "./inflector"

module Wrapper

  def self.squish(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.squish.to_ruby
  end
  def self.blank?(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.blank?.to_ruby
  end
  def self.pluralize(self : LibRuby::VALUE)#, count : LibRuby::VALUE, locale : LibRuby::VALUE)
    count = nil
    locale = :en
    str = String.from_ruby(self)
    str.pluralize(count, locale).to_ruby
  end
  def self.singularize(self : LibRuby::VALUE)#, locale : LibRuby::VALUE)
    locale = :en
    str = String.from_ruby(self)
    str.singularize(locale).to_ruby
  end
  def self.camelize(self : LibRuby::VALUE)#, first_letter : LibRuby::VALUE)
    first_letter = :upper
    str = String.from_ruby(self)
    str.camelize(first_letter).to_ruby
  end
  def self.titleize(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.titleize.to_ruby
  end
  def self.titlecase(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.titlecase.to_ruby
  end
  def self.as_underscore(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.as_underscore.to_ruby
  end
  def self.dasherize(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.dasherize.to_ruby
  end
  def self.demodulize(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.demodulize.to_ruby
  end
  def self.deconstantize(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.deconstantize.to_ruby
  end
  def self.tableize(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.tableize.to_ruby
  end
  def self.classify(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.classify.to_ruby
  end
  def self.humanize(self : LibRuby::VALUE)#, capitalize : LibRuby::VALUE)
    capitalize = true
    str = String.from_ruby(self)
    str.humanize(capitalize).to_ruby
  end
  def self.upcase_first(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    str.upcase_first.to_ruby
  end
  def self.foreign_key(self : LibRuby::VALUE)#, separate_class_name_and_id_with_underscore : LibRuby::VALUE)
    separate_class_name_and_id_with_underscore = true
    str = String.from_ruby(self)
    str.foreign_key(separate_class_name_and_id_with_underscore).to_ruby
  end
  def self.ordinal(self : LibRuby::VALUE)
    int = LibRuby.rb_num2int(self)
    int.ordinal.to_ruby
  end
  def self.ordinalize(self : LibRuby::VALUE)
    int = LibRuby.rb_num2int(self)
    int.ordinalize.to_ruby
  end
end
