require 'yaml'

class CLI
  def self.load_inventory(file)
    inventory = YAML.load_file(file)
    bundles = {}

    inventory["inventory"].each do |item|
      item.each do |key, values|
        bundle = FlowerShop::Bundle.new(key)
        values.each do |value|
          bundle.flowers << FlowerShop.const_get(value["type"]).new(value["qty"], value["price"]) if [ "Rose", "Lily", "Tulip" ].include?(value["type"])
        end
        bundles[key] = bundle
      end
    end

    bundles
  end

  def self.scan
    line = gets
    if line =~ /(\d+) ([A-Z]\d+)/
      yield Regexp.last_match[1], Regexp.last_match[2]
    else
      yield nil, nil
    end
  end

  def self.format_price(price)
    price = (price * 100).floor.to_f / 100.0
    "$" + ("%.02f" % price)
  end

  def self.format(result)
    res = "#{result.number_of_flowers} x #{result.code}: #{format_price(result.price)}\n"
    result.items.each do |item|
      res += "\t#{item.qty} x #{item.number_of_flowers / item.qty}: #{format_price(item.individual_price)}\n"
    end
    res
  end

  def self.run(arguments)
    file = arguments.pop || File.join(File.dirname(__FILE__), '..', 'data', 'inventory.yml')
    bundles = load_inventory(file)

    puts "Enter the quantity and bundle type:"

    scan do |qty, type|
      if qty && type
        if bundles.keys.include?(type)
          puts format(bundles[type].calculate(qty.to_i))
        else
          puts "Bundle code not found"
        end
      else
        puts "Invalid line: format <qty> <type>"
      end
    end
  end
end
