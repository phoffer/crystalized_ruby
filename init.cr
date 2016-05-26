require "./lib_ruby"
require "./integer_stuff"
require "./wrapper"
require "./geode"
require "./string_extensions"

fun init = Init_crystal_ext
  GC.init
  LibCrystalMain.__crystal_main(0, Pointer(Pointer(UInt8)).null)

  # miscellaneous stuff - "Geode"
  geode = LibRuby.rb_define_class("Geode", LibRuby.rb_cObject)
  LibRuby.rb_define_method(geode, "salute", ->Wrapper.salute_wrapper, 1)
  LibRuby0.rb_define_method(geode, "cr_array", ->Wrapper.array_to_ruby, 0)
  LibRuby0.rb_define_method(geode, "cr_hash", ->Wrapper.hash_to_ruby, 0)
  # LibRuby0.rb_define_method(integer, "cr_hash", ->Wrapper.hash_crystalize, 0)

  # Integer
  integer = LibRuby.rb_define_class("Integer", LibRuby.rb_cNumeric)
  LibRuby0.rb_define_method(integer, "cr_ordinal", ->Wrapper.ordinal, 0)

  # Hash
  hash = LibRuby.rb_define_class("Hash", LibRuby.rb_cObject)
  LibRuby0.rb_define_method(hash, "to_cr", ->Wrapper.parse_hash, 0)

  # String
  string = LibRuby.rb_define_class("String", LibRuby.rb_cObject)
  LibRuby0.rb_define_method(string, "cr_blank", ->Wrapper.blank, 0)
  LibRuby0.rb_define_method(string, "cr_squish", ->Wrapper.squish, 0)
  LibRuby0.rb_define_method(string, "cr_intern", ->Wrapper.to_sym_via_cr, 0)
  
  # CrMath
  cr_math = LibRuby.rb_define_class("CrMath", LibRuby.rb_cObject)
  LibRuby.rb_define_method(cr_math, "fibonacci", ->Wrapper.fibonacci_cr_wrapper, 1)
  LibRuby2.rb_define_method(cr_math, "add", ->Wrapper.add, 2)
end
