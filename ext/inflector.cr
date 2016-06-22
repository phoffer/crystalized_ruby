require "./src/lib_ruby/lib_ruby"
require "./src/inflector/wrapper"

fun init = Init_inflector
  GC.init
  LibCrystalMain.__crystal_main(0, Pointer(Pointer(UInt8)).null)

  # String
  string = LibRuby.rb_define_class("String", LibRuby.rb_cObject)

  LibRuby.rb_define_method(string, "cr_squish",        ->Wrapper.squish,        0)
  LibRuby.rb_define_method(string, "cr_blank?",        ->Wrapper.blank?,        0)
  LibRuby.rb_define_method(string, "cr_pluralize",     ->Wrapper.pluralize,     0)
  LibRuby.rb_define_method(string, "cr_singularize",   ->Wrapper.singularize,   0)
  LibRuby.rb_define_method(string, "cr_camelize",      ->Wrapper.camelize,      0)
  LibRuby.rb_define_method(string, "cr_titleize",      ->Wrapper.titleize,      0)
  LibRuby.rb_define_method(string, "cr_titlecase",     ->Wrapper.titlecase,     0)
  LibRuby.rb_define_method(string, "cr_as_underscore", ->Wrapper.as_underscore, 0)
  LibRuby.rb_define_method(string, "cr_dasherize",     ->Wrapper.dasherize,     0)
  LibRuby.rb_define_method(string, "cr_demodulize",    ->Wrapper.demodulize,    0)
  LibRuby.rb_define_method(string, "cr_deconstantize", ->Wrapper.deconstantize, 0)
  LibRuby.rb_define_method(string, "cr_tableize",      ->Wrapper.tableize,      0)
  LibRuby.rb_define_method(string, "cr_classify",      ->Wrapper.classify,      0)
  LibRuby.rb_define_method(string, "cr_humanize",      ->Wrapper.humanize,      0)
  LibRuby.rb_define_method(string, "cr_upcase_first",  ->Wrapper.upcase_first,  0)
  LibRuby.rb_define_method(string, "cr_foreign_key",   ->Wrapper.foreign_key,   0)
  

  integer = LibRuby.rb_define_class("Integer", LibRuby.rb_cNumeric)
  LibRuby.rb_define_method(integer, "cr_ordinal",      ->Wrapper.ordinal,       0)
  LibRuby.rb_define_method(integer, "cr_ordinalize",   ->Wrapper.ordinalize,    0)

end
