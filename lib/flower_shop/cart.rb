module FlowerShop
  class Cart
    attr_accessor :code

    def initialize(code)
      self.code = code
      @items = []
    end

    def add_item(qty, item)
      @items << CartItem.new(qty, item) if qty > 0
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
  end
end
