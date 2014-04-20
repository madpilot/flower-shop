module FlowerShop
  class Flower
    attr_accessor :qty, :price

    def initialize(qty, price)
      self.qty = qty
      self.price = price
    end
  end
end
