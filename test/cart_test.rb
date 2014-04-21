require 'bundler'
Bundler.require
require 'minitest/autorun'

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'flower_shop'))

module FlowerShop
  class CartTest < MiniTest::Test
    def test_bundle_r12
      bundle = Bundle.new('R12')
      bundle.flowers = [
        Rose.new(5, 6.99),
        Rose.new(10, 12.99)
      ]

      cart = Cart.new
      cart.add_bundle(10, bundle)

      assert_equal 1, cart.number_of_bundles
      assert_equal 10, cart.number_of_flowers
      assert_equal 12.99, (cart.price * 100).to_i.to_f / 100.0

      item = cart.items[0]
      assert_equal 1, item.qty
      assert_equal 10, item.item.qty
    end

    def test_bundle_l09
      bundle = Bundle.new('L09')
      bundle.flowers = [
        Lily.new(3,9.95),
        Lily.new(6, 16.95),
        Lily.new(9, 24.95)
      ]

      cart = Cart.new
      cart.add_bundle(15, bundle)

      assert_equal 2, cart.number_of_bundles
      assert_equal 15, cart.number_of_flowers
      assert_equal 41.90, (cart.price * 100).to_i.to_f / 100.0

      item = cart.items[0]
      assert_equal 1, item.qty
      assert_equal 6, item.item.qty

      item = cart.items[1]
      assert_equal 1, item.qty
      assert_equal 9, item.item.qty
    end

    def test_bundle_t58
      bundle = Bundle.new('T58')
      bundle.flowers = [
        Tulip.new(3, 5.95),
        Tulip.new(5, 9.95),
        Tulip.new(9, 16.99)
      ]

      cart = Cart.new
      cart.add_bundle(13, bundle)

      assert_equal 3, cart.number_of_bundles
      assert_equal 13, cart.number_of_flowers
      assert_equal 25.85, (cart.price * 100).to_i.to_f / 100.0

      item = cart.items[0]
      assert_equal 1, item.qty
      assert_equal 3, item.item.qty

      item = cart.items[1]
      assert_equal 2, item.qty
      assert_equal 5, item.item.qty
    end
  end
end
