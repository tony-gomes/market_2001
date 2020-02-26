require_relative 'test_helper'
require './lib/item'
require './lib/vendor'

class VendorTest < MiniTest::Test
  def setup
    @item1 = Item.new({name: 'Peach', price: '$0.75'})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists_with_attributes
    assert_instance_of Vendor, @vendor
    assert_equal "Rocky Mountain Fresh", @vendor.name
  end

  def test_it_starts_with_no_inventory
    expected1 = {}
    assert_equal expected1, @vendor.inventory
  end

  def test_it_can_check_stock
    assert_equal 0, @vendor.check_stock(@item1)
    assert_equal 0, @vendor.check_stock(@item2)
  end

  def test_it_can_add_stock
    assert_equal 0, @vendor.check_stock(@item1)
    @vendor.stock(@item1, 30)
    expected1 = {@item1 => 30}
    assert_equal expected1, @vendor.inventory
    assert_equal 30, @vendor.check_stock(@item1)

    @vendor.stock(@item1, 25)
    assert_equal 55, @vendor.check_stock(@item1)
    expected2 = {@item1 => 55}
    assert_equal expected2, @vendor.inventory

    assert_equal 0, @vendor.check_stock(@item2)
    @vendor.stock(@item2, 12)
    assert_equal 12, @vendor.check_stock(@item2)
    expected3 = {@item1 => 55, @item2 => 12}
    assert_equal expected3, @vendor.inventory
  end
end
