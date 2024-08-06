# frozen_string_literal: true

class Catalog
  def initialize(products)
    @products = products
  end

  def find_product(code)
    @products.find { |product| product.code == code }
  end
end
