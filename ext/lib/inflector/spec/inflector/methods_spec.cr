require "../spec_helper"

# these are the inline examples from comments in Inflector code
describe "Inflector" do
  describe "#camelize" do
    it "handles base case" do
      (Inflector.camelize("active_model")).should                 eq("ActiveModel")
    end
    it "handles base case with lowerCamel" do
      (Inflector.camelize("active_model", false)).should          eq("activeModel")
    end
    it "converts / to :: with uppper CC" do
      (Inflector.camelize("active_model/errors")).should          eq("ActiveModel::Errors")
    end
    it "converts / to :: with lower CC" do
      (Inflector.camelize("active_model/errors", false)).should   eq("activeModel::Errors")
    end
  end
  describe "#underscore" do
    it "handles base case" do
      (Inflector.underscore("ActiveModel")).should                eq("active_model")
    end
    it "converts :: to /" do
      (Inflector.underscore("ActiveModel::Errors")).should        eq("active_model/errors")
    end
    it "doesn't split acronyms" do
      (Inflector.underscore("HTTP::Errors")).should               eq("http/errors")
    end
  end
  describe "#humanize" do
    it "handles base case" do
      (Inflector.humanize("employee_salary")).should              eq("Employee salary")
    end
    it "doesn't add ID to column/attribute names" do
      (Inflector.humanize("author_id")).should                    eq("Author")
    end
    it "respects capitalize parameter" do
      (Inflector.humanize("employee_salary", capitalize: false)).should eq("employee salary")
      (Inflector.humanize("author_id", capitalize: false)).should eq("author")
    end
    it "recognizes Id by itself" do
      (Inflector.humanize("_id")).should                          eq("Id")
    end
  end
  describe "#upcase_first" do
    it "handles base case" do
      (Inflector.upcase_first("what a Lovely Day")).should        eq("What a Lovely Day")
    end
    it "capitalizes char" do
      (Inflector.upcase_first("w")).should                        eq("W")
    end
    it "does not error on empty string" do
      (Inflector.upcase_first("")).should                         eq("")
    end
  end
  describe "#titleize" do
    it "handles base case" do
      (Inflector.titleize("man from the boondocks")).should       eq("Man From The Boondocks")
    end
    it "translates dash into space" do
      (Inflector.titleize("x-men: the last stand")).should        eq("X Men: The Last Stand")
    end
    it "splits camel case title" do
      (Inflector.titleize("TheManWithoutAPast")).should           eq("The Man Without A Past")
    end
    it "splits snake case title" do
      (Inflector.titleize("raiders_of_the_lost_ark")).should      eq("Raiders Of The Lost Ark")
    end
  end
  describe "#classify" do
    it "converts snake to camel case" do
      (Inflector.classify("ham_and_eggs")).should                 eq("HamAndEgg")
    end
    it "singularizes" do
      (Inflector.classify("posts")).should                        eq("Post")
    end
  end
  describe "#dasherize" do
    it "turns underscore into dash" do
      (Inflector.dasherize("puni_puni")).should                   eq("puni-puni")
    end
  end
  describe "#demodulize" do
    it "" do
      big_str = "ActiveRecord::CoreExtensions::String::Inflections"
      (Inflector.demodulize(big_str)).should                      eq("Inflections")
    end
    it "" do
      (Inflector.demodulize("Inflections")).should                eq("Inflections")
    end
    it "" do
      (Inflector.demodulize("::Inflections")).should              eq("Inflections")
    end
    it "" do
      (Inflector.demodulize("")).should                           eq("")
    end
  end
  describe "#deconstantize" do
    it "" do
      (Inflector.deconstantize("Net::HTTP")).should               eq("Net")
    end
    it "" do
      (Inflector.deconstantize("::Net::HTTP")).should             eq("::Net")
    end
    it "" do
      (Inflector.deconstantize("String")).should                  eq("")
    end
    it "" do
      (Inflector.deconstantize("::String")).should                eq("")
    end
    it "" do
      (Inflector.deconstantize("")).should                        eq("")
    end
  end
  describe "#foreign_key" do
    it "" do
      (Inflector.foreign_key("Message")).should                   eq("message_id")
    end
    it "" do
      (Inflector.foreign_key("Message", false)).should            eq("messageid")
    end
    it "" do
      (Inflector.foreign_key("Admin::Post")).should               eq("post_id")
    end
  end
  describe "#ordinal" do
    it "" do
      (Inflector.ordinal(1)).should                               eq("st")
    end
    it "" do
      (Inflector.ordinal(2)).should                               eq("nd")
    end
    it "" do
      (Inflector.ordinal(1002)).should                            eq("nd")
    end
    it "" do
      (Inflector.ordinal(1003)).should                            eq("rd")
    end
    it "" do
      (Inflector.ordinal(-11)).should                             eq("th")
    end
    it "" do
      (Inflector.ordinal(-1021)).should                           eq("st")
    end
  end
  describe "#ordinalize" do
    it "" do
      (Inflector.ordinalize(1)).should                            eq("1st")
    end
    it "" do
      (Inflector.ordinalize(2)).should                            eq("2nd")
    end
    it "" do
      (Inflector.ordinalize(1002)).should                         eq("1002nd")
    end
    it "" do
      (Inflector.ordinalize(1003)).should                         eq("1003rd")
    end
    it "" do
      (Inflector.ordinalize(-11)).should                          eq("-11th")
    end
    it "" do
      (Inflector.ordinalize(-1021)).should                        eq("-1021st")
    end
  end
  describe "#pluralize" do
    it "" do
      (Inflector.pluralize("post")).should                        eq("posts")
    end
    it "" do
      (Inflector.pluralize("posts")).should                       eq("posts")
    end
    it "" do
      (Inflector.pluralize("octopus")).should                     eq("octopi")
    end
    it "" do
      (Inflector.pluralize("sheep")).should                       eq("sheep")
    end
    it "" do
      (Inflector.pluralize("words")).should                       eq("words")
    end
    it "" do
      (Inflector.pluralize("CamelOctopus")).should                eq("CamelOctopi")
    end
  end
  describe "#singularize" do
    it "" do
      (Inflector.singularize("posts")).should                     eq("post")
    end
    it "" do
      (Inflector.singularize("post")).should                      eq("post")
    end
    it "" do
      (Inflector.singularize("octopi")).should                    eq("octopus")
    end
    it "" do
      (Inflector.singularize("sheep")).should                     eq("sheep")
    end
    it "" do
      (Inflector.singularize("word")).should                      eq("word")
    end
    it "" do
      (Inflector.singularize("CamelOctopi")).should               eq("CamelOctopus")
    end
  end
end
