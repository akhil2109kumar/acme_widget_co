# frozen_string_literal: true

class Offer
  def initialize(product_code, quantity, discount_percentage)
    @product_code = product_code
    @quantity = quantity
    @discount_percentage = discount_percentage
  end

  def apply(items)
    applicable_items = items.select { |item| item.code == @product_code }
    return 0 if applicable_items.empty?
  
    discount_count = (applicable_items.size / @quantity).floor
    discount_amount = applicable_items.first.price * @discount_percentage / 100.0
    discount_count * discount_amount
  end
end
