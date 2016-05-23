module Wrapper
  def self.rb_str_to_cr_str(str : LibRuby::VALUE)
    puts (rb_str = LibRuby.rb_str_to_str(str)).inspect
    puts pointerof(rb_str).inspect
    c_str = LibRuby.rb_string_value_cstr(pointerof(rb_str))
    puts c_str.inspect
    cr_str = String.new(c_str)
  end

  def self.salute_wrapper(self : LibRuby::VALUE, name : LibRuby::VALUE)
    # str = rb_str_to_cr_str(name)
    str = String.from_ruby(name)
    Greeter.salute(str).to_ruby
  end

  def self.fibonacci_cr_wrapper(self : LibRuby::VALUE, value : LibRuby::VALUE)
    int_value = Int32.from_ruby(value)
    IntegerStuff.fibonacci_cr(int_value).to_ruby
  end

  def self.add(self : LibRuby::VALUE, a : LibRuby::VALUE, b : LibRuby::VALUE)
    a = LibRuby.rb_num2int(a)
    b = LibRuby.rb_num2int(b)
    LibRuby.rb_int2inum(IntegerStuff.add(a, b))
  end

  def self.blank(self : LibRuby::VALUE)
    # str = rb_str_to_cr_str(self)
    str = String.from_ruby(self)
    StringExtensions.whitespace_only?(str).to_ruby
  end

  def self.squish(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    StringExtensions.squish(str).to_ruby
  end

  def self.ordinal(self : LibRuby::VALUE)
    int = LibRuby.rb_num2int(self)
    StringExtensions.ordinal(int).to_ruby
  end
end
