require_relative 'test_helper'
require './lib/item'
require './lib/vendor'
require './lib/market'

class MarketTest < MiniTest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  def test_it_exists_with_attributes
    assert_instance_of Market, @market
    assert_equal "South Pearl Street Farmers Market", @market.name
  end

  def test_it_starts_with_no_vendors
    assert_equal [], @market.vendors
  end

  def test_it_can_add_vendors
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @market.add_vendor(@vendor1)
    expected1 = [@vendor1]
    assert_equal expected1, @market.vendors

    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @market.add_vendor(@vendor2)
    expected2 = [@vendor1, @vendor2]
    assert_equal expected2, @market.vendors

    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor3)
    expected3 = [@vendor1, @vendor2, @vendor3]
    assert_equal expected3, @market.vendors
  end

  def test_it_can_get_vendor_names
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expected1 = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal expected1, @market.vendor_names
  end

  def test_it_can_get_vendors_that_sell_items
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @market.add_vendor(@vendor1)
    assert_equal [@vendor1], @market.vendors_that_sell(@item1)

    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @market.add_vendor(@vendor2)
    assert_equal [@vendor2], @market.vendors_that_sell(@item4)

    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor3)
    assert_equal [@vendor1, @vendor3], @market.vendors_that_sell(@item1)
  end

  def test_it_can_get_total_inventory
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @market.add_vendor(@vendor1)

    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @market.add_vendor(@vendor2)

    @vendor3.stock(@item1, 65)
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor3)

    assert @market.total_inventory.key?(@item1)
    assert @market.total_inventory.key?(@item2)
    assert @market.total_inventory.key?(@item3)
  end
end
