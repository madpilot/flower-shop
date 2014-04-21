module FlowerShop
  class Bundle
    attr_accessor :code

    def initialize(code, flowers = [])
      self.code = code
      self.flowers = flowers
    end

    def flowers
      @flowers ||= []
    end

    def flowers=(flowers)
      @flowers = flowers
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
    def calculate(qty)
      flowers = self.flowers.sort { |x, y| x.qty <=> y.qty }

      # We can cull some of the number space, as we know that
      # there is a maximum number (qty required / qty in the bundle)
      # for each of the bundles. We can also ignore the state where
      # all the quantites are 0
      max_bundles = flowers.map{ |f| qty / f.qty }
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

      carts = []
      quantities.map do |mask|
        cart = Cart.new(self.code)
        mask.each_with_index do |quantity, index|
          cart.add_item(quantity, flowers[index])
        end
        carts << cart if cart.number_of_flowers == qty
      end
      carts.sort{ |x, y| x.number_of_bundles <=> y.number_of_bundles }.first
    end
  end
end
