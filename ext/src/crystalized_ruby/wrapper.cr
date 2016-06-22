module Wrapper
  def self.inspect(obj : LibRuby::VALUE)
    ptr = LibRuby.rb_class2name(obj)
    cr_str = String.new(ptr)
    # puts LibRuby.rb_type(obj)
    cr_str.to_ruby
  end
  def self.rb_boomerang(obj : LibRuby::VALUE)
    o = RubyImporter.from_ruby(obj)
    o.to_ruby
  end
  def self.rb_class(obj : LibRuby::VALUE)
    o = RubyImporter.rb_class(obj)
    o.to_ruby
  end
  def self.new_reg(self : LibRuby::VALUE)
    LibRuby.rb_reg_new_str("world".to_ruby, 0)
  end
  def self.to_s(obj : LibRuby::VALUE)
    RubyImporter.from_ruby(obj).to_ruby
  end
  def self.rb_str_to_cr_str(str : LibRuby::VALUE)
    puts (rb_str = LibRuby.rb_str_to_str(str)).inspect
    puts pointerof(rb_str).inspect
    c_str = LibRuby.rb_string_value_cstr(pointerof(rb_str))
    puts c_str.inspect
    cr_str = String.new(c_str)
  end

  def self.salute_wrapper(self : LibRuby::VALUE, name : LibRuby::VALUE)
    str = String.from_ruby(name)
    Geode.salute(str).to_ruby
  end

  def self.fibonacci_cr_wrapper(self : LibRuby::VALUE, value : LibRuby::VALUE)
    int_value = Int.from_ruby(value)
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
  def self.hash_crystalize(self : LibRuby::VALUE)
    Hash.from_ruby.to_ruby
  end
  def self.parse_hash(self : LibRuby::VALUE)
    puts "Can't convert Ruby hash to Crystal yet, so here's a Crystal hash for you"
    { :hello => 12, "what's this?" => :crystal, "this is cool" => true }.to_ruby
  end
  def self.hash_to_ruby(self : LibRuby::VALUE)
    { :hello => 12, "hello" => :goodbye }.to_ruby
  end
  def self.array_to_ruby(self : LibRuby::VALUE)
    [1, "two", :three].to_ruby
  end
  def self.to_sym_via_cr(self : LibRuby::VALUE)
    str = String.from_ruby(self)
    LibRuby.rb_id2sym(LibRuby.rb_intern(str))
  end
end
