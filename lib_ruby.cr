lib LibRuby
  type VALUE = Void*
  type METHOD_FUNC = VALUE, VALUE -> VALUE # STUB

  $rb_cObject : VALUE
  $rb_cNumeric : VALUE

  fun rb_num2int(value : VALUE) : Int32
  fun rb_int2inum(value : Int32) : VALUE

  fun rb_str_to_str(value : VALUE) : VALUE
  fun rb_string_value_cstr(value_ptr : VALUE*) : UInt8*
  fun rb_str_new_cstr(str : UInt8*) : VALUE
  fun rb_define_class(name : UInt8*, super : VALUE) : VALUE
  fun rb_define_module(name : UInt8*, super : VALUE) : VALUE
  fun rb_define_method(klass : VALUE, name : UInt8*, func : METHOD_FUNC, argc : Int32)
  fun rb_define_singleton_method(klass : VALUE, name : UInt8*, func : METHOD_FUNC, argc : Int32)
end

lib LibRuby0
  type METHOD_FUNC = LibRuby::VALUE -> LibRuby::VALUE
  fun rb_define_method(klass : LibRuby::VALUE, name : UInt8*, func : METHOD_FUNC, argc : Int32)
  fun rb_define_singleton_method(klass : LibRuby::VALUE, name : UInt8*, func : METHOD_FUNC, argc : Int32)
end

lib LibRuby2
  type METHOD_FUNC = LibRuby::VALUE, LibRuby::VALUE, LibRuby::VALUE -> LibRuby::VALUE
  fun rb_define_method(klass : LibRuby::VALUE, name : UInt8*, func : METHOD_FUNC, argc : Int32)
  fun rb_define_singleton_method(klass : LibRuby::VALUE, name : UInt8*, func : METHOD_FUNC, argc : Int32)
end

struct Nil
  def to_ruby
    Pointer(Void).new(8_u64).as(LibRuby::VALUE)
  end
end

struct Bool
  def to_ruby
    Pointer(Void).new(self ? 20_u64 : 0_u64).as(LibRuby::VALUE)
  end
end

class String
  def to_ruby
    LibRuby.rb_str_new_cstr(self)
  end

  def self.from_ruby(str : LibRuby::VALUE)
    rb_str = LibRuby.rb_str_to_str(str)
    c_str = LibRuby.rb_string_value_cstr(pointerof(rb_str))
    cr_str = String.new(c_str)
  end
end

struct Int32
  def to_ruby
    LibRuby.rb_int2inum(self)
  end

  def self.from_ruby(int)
    LibRuby.rb_num2int(int)
  end
end
