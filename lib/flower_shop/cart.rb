module FlowerShop
  class Cart
    def initialize
      @items = []
    end

    def add_item(qty, item)
      @items << CartItem.new(qty, item) if qty > 0
    end

    def add_bundle(qty, bundle)
      minimize_bundle!(qty, bundle)
      self
    end

    def items
      @items
    end

    def number_of_bundles
      items.inject(0) { |t, i| t + i.qty }
    end

    def number_of_flowers
      @items.inject(0) { |t, i| t + i.number_of_flowers }
    end

    def price
      @items.inject(0) { |t, i| t + i.price }
    end

    # Recursive function that increments the number, whose parts are held in
    # an array. It's like an assembly increment, except you can have arbitary
    # overflow limits for each "bit" of the number
    def increment_and_carry(numbers, limits)
      numbers = numbers.dup
      limits = limits.dup

      number = numbers.pop
      limit = limits.pop

      if(number + 1 > limit)
        numbers = increment_and_carry(numbers, limits)
        numbers.push(0)
      else
        numbers.push(number + 1)
      end

      numbers
    end

    # This is a knapsack problem, where flower qty is weight, and bundle size is
    # value.
    # However, we want to minimise the number of values, not maximise.
    # Use brute force (across a minimised data space) as the data set is very small
    # If it the clients starts going crazy with the number of bundles, we can
    # use a more optimised algorithm
    def minimize_bundle!(qty, bundle)
      items = bundle.items.sort { |x, y| x.qty <=> y.qty }

      # We can cull some of the number space, as we know that
      # there is a maximum number (qty required / qty in the bundle)
      # for each of the bundles. We can also ignore the state where
      # all the quantites are 0
      max_bundles = items.map{ |f| qty / f.qty }
      max = max_bundles.inject(0) { |t, v| t + v }

      # Create 2D array that stores all of the possible quanity permutations
      # that fall under the max value of each bundle
      # We are done at the point we hit the the max for each bundle
      quantities = []
      current = [0] * max_bundles.length
      begin
        current = self.increment_and_carry(current, max_bundles)
        quantities << current
      end while current.inject(0) { |t, v| t + v } < max

      possibilities = []

      # Find all the possibilities
      quantities.each do |mask|
        p = { total: 0, bundles: 0, items: [] }
        mask.each_with_index do |quantity, index|
          p[:total] += items[index].qty * quantity
          p[:bundles] += quantity
          p[:items] << {
            flower: items[index],
            qty: quantity
          }
        end
        # If the total number of flowers is equal to the requested qty
        # we have a winner
        possibilities << p if p[:total] == qty
      end

      # Find the possiblity with the least number of bundles
      item = possibilities.sort{ |x, y| x[:bundles] <=> y[:bundles] }.first
      item[:items].each { |f| self.add_item(f[:qty], f[:flower]) } unless item.nil?

      self
    end
  end
end
