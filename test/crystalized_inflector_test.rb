require 'test_helper'
require_relative '../ext/inflector'

class CrystalizedInflectorTest < Minitest::Test
  def test_ordinals
    assert_equal 1.cr_ordinalize    , "1st"
    assert_equal 2.cr_ordinalize    , "2nd"
    assert_equal 1002.cr_ordinalize , "1002nd"
    assert_equal 1003.cr_ordinalize , "1003rd"
    assert_equal -11.cr_ordinalize  , "-11th"
    assert_equal -1001.cr_ordinalize, "-1001st"
    assert_equal 1.cr_ordinal       , "st"
    assert_equal 2.cr_ordinal       , "nd"
    assert_equal 1002.cr_ordinal    , "nd"
    assert_equal 1003.cr_ordinal    , "rd"
    assert_equal -11.cr_ordinal     , "th"
    assert_equal -1001.cr_ordinal   , "st"
  end

  def test_blank
    assert_equal ''.cr_blank?      , true
    assert_equal '   '.cr_blank?   , true
    assert_equal "\t\n\r".cr_blank?, true
    assert_equal ' blah '.cr_blank?, false
    assert_equal "\u00a0".cr_blank?, true
  end

  def test_squish
    assert_equal " foo   bar    \n   \t   boo".cr_squish, "foo bar boo"
  end

  def test_pluralize
    assert_equal "post".cr_pluralize            , "posts"
    assert_equal "octopus".cr_pluralize         , "octopi"
    assert_equal "sheep".cr_pluralize           , "sheep"
    assert_equal "words".cr_pluralize           , "words"
    assert_equal "the blue mailman".cr_pluralize, "the blue mailmen"
    assert_equal "CamelOctopus".cr_pluralize    , "CamelOctopi"
    assert_equal "apple".cr_pluralize           , "apples"
    assert_equal "apples".cr_pluralize          , "apples"
  end

  def test_singularize
    assert_equal "apple".cr_singularize           , "apple"
    assert_equal "apples".cr_singularize          , "apple"
    assert_equal "posts".cr_singularize           , "post"
    assert_equal "octopi".cr_singularize          , "octopus"
    assert_equal "sheep".cr_singularize           , "sheep"
    assert_equal "word".cr_singularize            , "word"
    assert_equal "the blue mailmen".cr_singularize, "the blue mailman"
    assert_equal "CamelOctopi".cr_singularize     , "CamelOctopus"
  end

  def test_camelize
    assert_equal "active_record".cr_camelize       , "ActiveRecord"
    assert_equal "active_record".cr_camelize       , "activeRecord"
    assert_equal "active_record/errors".cr_camelize, "ActiveRecord::Errors"
    assert_equal "active_record/errors".cr_camelize, "activeRecord::Errors"
  end

  def test_titleize
    assert_equal "man from the boondocks".cr_titleize, "Man From The Boondocks"
    assert_equal "x-men: the last stand".cr_titleize , "X Men: The Last Stand"
  end

  def test_underscore
    assert_equal "ActiveModel".cr_as_underscore        , "active_model"
    # assert_equal "ActiveModel".cr_underscore           , "active_model" # native crystal implementation doesn't handle custom things like ::
    assert_equal "ActiveModel::Errors".cr_as_underscore, "active_model/errors"
    # assert_equal "ActiveModel::Errors".cr_underscore   , "active_model/errors" # native crystal implementation doesn't handle custom things like ::
  end

  def test_dasherize
    assert_equal "puni_puni".cr_dasherize, "puni-puni"
  end

  def test_demodulize
    assert_equal "ActiveRecord::CoreExtensions::String::Inflections".cr_demodulize, "Inflections"
    assert_equal "Inflections".cr_demodulize                                      , "Inflections"
    assert_equal "::Inflections".cr_demodulize                                    , "Inflections"
    assert_equal "".cr_demodulize                                                 , ""
  end

  def test_deconstantize
    assert_equal "Net::HTTP".cr_deconstantize  , "Net"
    assert_equal "::Net::HTTP".cr_deconstantize, "::Net"
    assert_equal "String".cr_deconstantize     , ""
    assert_equal "::String".cr_deconstantize   , ""
    assert_equal "".cr_deconstantize           , ""
  end

  def test_tableize
    assert_equal "RawScaledScorer".cr_tableize, "raw_scaled_scorers"
    assert_equal "ham_and_egg".cr_tableize    , "ham_and_eggs"
    assert_equal "fancyCategory".cr_tableize  , "fancy_categories"
  end

  def test_classify
    assert_equal "ham_and_eggs".cr_classify, "HamAndEgg"
    assert_equal "posts".cr_classify       , "Post"
  end

  def test_humanize
    assert_equal "employee_salary".cr_humanize, "Employee salary"
    assert_equal "author_id".cr_humanize      , "Author"
    assert_equal "author_id".cr_humanize      , "author"
    assert_equal "_id".cr_humanize            , "Id"
  end

  def test_upcase_first
    assert_equal "what a Lovely Day".cr_upcase_first, "What a Lovely Day"
    assert_equal "w".cr_upcase_first                , "W"
    assert_equal "".cr_upcase_first                 , ""
  end

  def test_foreign_key
    assert_equal "Message".cr_foreign_key    , "message_id"
    assert_equal "Message".cr_foreign_key    , "messageid"
    assert_equal "Admin::Post".cr_foreign_key, "post_id"
  end
end

