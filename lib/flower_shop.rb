require File.join(File.dirname(__FILE__), 'flower_shop', 'bundle.rb') 
require File.join(File.dirname(__FILE__), 'flower_shop', 'flower.rb')
require File.join(File.dirname(__FILE__), 'flower_shop', 'lily.rb') 
require File.join(File.dirname(__FILE__), 'flower_shop', 'rose.rb')  
require File.join(File.dirname(__FILE__), 'flower_shop', 'tulip.rb')

module FlowerShop
end

if false
inventory = {
  R12: Bundle.new([ Rose.new(5, 6.99), Rose.new(10, 12.99) ]),
  L09: Bundle.new([ Lily.new(3, 9.95), Lily.new(6, 16.95), Lily.new(9, 24.95) ]),
  T58: Bundle.new([ Tulip.new(3, 5.95), Tulip.new(5, 9.95), Tulip.new(9, 16.99) ])
}

def format_price(price)
  price = (price * 100).floor.to_f / 100.0
  "$" + ("%.02f" % price)
end

def format(type, result)
  res = "#{result[:total]} x #{type}: #{format_price(result[:price])}\n"
  result[:flowers].each do |item|
    res += "\t#{item[:qty]} x #{item[:flower].qty}: #{format_price(item[:qty] * item[:flower].price)}\n" unless item[:qty] == 0
  end
  res
end

puts format('R12', inventory[:R12].calculate(10))
puts format('L09', inventory[:L09].calculate(15))
puts format('T58', inventory[:T58].calculate(13))
end
