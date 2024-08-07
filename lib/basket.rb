# frozen_string_literal: true

class Basket
  def initialize(catalog, delivery_rules, offers)
    @catalog = catalog
    @delivery_rules = delivery_rules.sort_by(&:min_amount).reverse
    @offers = offers
    @items = []
  end

  def add(product_code)
    product = @catalog.find_product(product_code)
    raise ArgumentError, "Invalid product code: #{product_code}" unless product

    @items << product
  end

  def total
    subtotal = @items.sum(&:price)
    discount = apply_offers
    delivery_charge = calculate_delivery_charge(subtotal - discount)
    subtotal - discount + delivery_charge
  end

  private

  def apply_offers
    @offers.sum { |offer| offer.apply(@items) }
  end

  def calculate_delivery_charge(total)
    @delivery_rules.find { |rule| rule.applies?(total) }&.charge || 0
  end
end
