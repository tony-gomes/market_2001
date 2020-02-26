class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    return 0 unless inventory.key?(item)

    @inventory.fetch(item)
  end

  def stock(item, quantity)
    @inventory[item] unless @inventory.any?(item)

    @inventory[item] += quantity
  end
end
