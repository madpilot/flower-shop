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

    def items
      flowers
    end
  end
end
