require "./src/lib_ruby/lib_ruby"
require "./src/crystalized_ruby/integer_stuff"
require "./src/crystalized_ruby/wrapper"
require "./src/crystalized_ruby/geode"
require "./src/crystalized_ruby/string_extensions"

fun init = Init_crystalized_ruby
  GC.init
  LibCrystalMain.__crystal_main(0, Pointer(Pointer(UInt8)).null)

  # miscellaneous stuff - "Geode"
  geode = LibRuby.rb_define_module("Geode", LibRuby.rb_cObject)
  stuff = LibRuby.rb_define_class("Stuff", geode)
  LibRuby1.rb_define_method(stuff, "salute", ->Wrapper.salute_wrapper, 1)
  LibRuby.rb_define_method(stuff, "cr_array", ->Wrapper.array_to_ruby, 0)
  LibRuby.rb_define_method(stuff, "cr_hash", ->Wrapper.hash_to_ruby, 0)
  # LibRuby.rb_define_method(integer, "cr_hash", ->Wrapper.hash_crystalize, 0)

  # Integer
  integer = LibRuby.rb_define_class("Integer", LibRuby.rb_cNumeric)
  LibRuby.rb_define_method(integer, "cr_ordinal", ->Wrapper.ordinal, 0)

  # Hash
  hash = LibRuby.rb_define_class("Hash", LibRuby.rb_cObject)
  LibRuby.rb_define_method(hash, "to_cr", ->Wrapper.parse_hash, 0)

  # String
  string = LibRuby.rb_define_class("String", LibRuby.rb_cObject)
  LibRuby.rb_define_method(string, "cr_blank", ->Wrapper.blank, 0)
  LibRuby.rb_define_method(string, "cr_squish", ->Wrapper.squish, 0)
  LibRuby.rb_define_method(string, "cr_intern", ->Wrapper.to_sym_via_cr, 0)
  
  # CrMath
  cr_math = LibRuby.rb_define_class("CrMath", LibRuby.rb_cObject)
  LibRuby1.rb_define_method(cr_math, "fibonacci", ->Wrapper.fibonacci_cr_wrapper, 1)
  LibRuby2.rb_define_method(cr_math, "add", ->Wrapper.add, 2)

  # poking around
  obj = LibRuby.rb_define_class("Object", LibRuby.rb_cBasicObject)
  LibRuby.rb_define_method(obj, "cr_inspect", ->Wrapper.inspect, 0)
  LibRuby.rb_define_method(obj, "cr_boomerang", ->Wrapper.rb_boomerang, 0)
  LibRuby.rb_define_method(obj, "cr_class", ->Wrapper.rb_class, 0)
  LibRuby.rb_define_method(obj, "cr_to_s", ->Wrapper.to_s, 0)
  LibRuby.rb_define_method(obj, "cr_regex", ->Wrapper.new_reg, 0)


end
