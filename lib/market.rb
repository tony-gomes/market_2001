class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.select { |vendor| vendor.inventory.include?(item) }
  end

  def total_inventory
    all_inventory = {}

    @vendors.reduce({}) do |inventory_results, vendor|
      vendor.inventory.each do |item|
        all_inventory[item.first] = inventory_results unless all_inventory.key?(item)
        inventory_results[:quantity] = item.last
        inventory_results[:vendors] = item.last
        inventory_results
      end
      all_inventory
    end
  end
end
