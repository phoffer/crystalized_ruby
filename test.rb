# First, build the extension by running `make`
require './crystal_ext'

str_squish = " foo   bar    \n   \t   boo"
puts str_squish.cr_squish

puts 12.cr_ordinal
crm = CrMath.new
puts crm.add(2,3) + 2
puts crm.fibonacci(10)

exit
require 'active_support/all'
require 'fast_blank'

class String
  def cr_blank?
    empty? || cr_blank
  end
end

str = ARGV[0]
g = Greeter.new
# puts g.salute(str || 'world')
# puts ARGV[0].to_s.cr_blank
num = rand(20)
# puts "#{num.to_s}#{g.cr_ordinal(num)}"


squish = " foo   bar    \n   \t   boo"
# puts squish.cr_squish

crm = CrMath.new
# puts crm.add(2,3) + 2
# puts crm.fibonacci(10)


# double check
# puts '---------- double check---------------'
# puts (0..100).to_a.all? { |i| num.ordinal == g.cr_ordinal(num) }

class Integer
  def ordinal
    'th'
  end
end


puts 1.ordinal

exit

require 'descriptive_statistics'

str ||= 'world'
count = 1_000_000_000
count = 100_000_000
timing = []
# puts 'AS blank?'
# puts 'fast blank?'
puts 'crystal blank?'
# puts 'crystal squish'
# puts 'AS squish'
tt = Time.now
count.times do |i|
  # print "#{i}/#{count} in #{dur = (Time.now - t).round(2)}\r"
  # g.salute(str)
  t = Time.now
  # " ".blank?
  " ".cr_blank?
  # " ".cr_squish
  # " ".squish
  t2 = Time.now
  timing << (t2 - t)
end
puts "script time: #{(duration = Time.now - tt)}"
puts "count: #{count}"
puts "n/second: #{(count / duration).round}"
puts "max duration: #{timing.max}"
total_time = timing.inject(:+)
avg_time = total_time / timing.size
puts "avg_time: #{avg_time}"
above = timing.count{ |d| d > avg_time }
puts "above average: #{above}"
puts "stdev: #{timing.standard_deviation}"
puts
