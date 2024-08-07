# frozen_string_literal: true

class DeliveryRule
  attr_reader :min_amount, :charge

  def initialize(min_amount, charge)
    @min_amount = min_amount
    @charge = charge
  end

  def applies?(total)
    total >= @min_amount
  end
end
