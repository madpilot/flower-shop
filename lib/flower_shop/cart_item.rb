module FlowerShop
  class CartItem
    attr_accessor :qty, :item

    def initialize(qty, item)
      self.qty = qty
      self.item = item
    end

    def number_of_flowers
      self.qty * self.item.qty
    end

    def price
      self.qty * self.item.price
    end

    def individual_price
      self.item.price
    end
  end
end
