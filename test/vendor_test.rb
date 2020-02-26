require_relative 'test_helper'
require './lib/item'
require './lib/vendor'

class VendorTest < MiniTest::Test
  def setup
    @item1 = Item.new({name: 'Peach', price: '$0.75'})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  def test_it_exists_with_attributes
    assert_instance_of Item, @item1
  end
end
