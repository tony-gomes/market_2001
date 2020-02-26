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

  def potential_revenue
    total_potential_revenue = 0.0
    @inventory.each do |item|
      price = item.first.price.delete('$').to_f
      total_potential_revenue += (price * item.last)
    end
    total_potential_revenue
  end
end
