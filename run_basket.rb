require_relative 'lib/basket'
require_relative 'lib/product'
require_relative 'lib/catalog'
require_relative 'lib/delivery_rule'
require_relative 'lib/offer'

# Initialize catalog
catalog = Catalog.new([
  Product.new('R01', 'Red Widget', 32.95),
  Product.new('G01', 'Green Widget', 24.95),
  Product.new('B01', 'Blue Widget', 7.95)
])

# Initialize delivery rules
delivery_rules = [
  DeliveryRule.new(0, 4.95), # orders under $50
  DeliveryRule.new(50, 2.95), # orders under $90
  DeliveryRule.new(90, 0) # orders of $90 or more
]

# Initialize offers
offers = [
  Offer.new('R01', 2, 50) # buy one red widget, get the second half price
]

# Create a new basket
basket = Basket.new(catalog, delivery_rules, offers)

puts "Welcome to the Acme Widget Co Basket System!"
puts "Available products: R01 (Red Widget), G01 (Green Widget), B01 (Blue Widget)"
puts "Enter product codes one by one. Type 'done' when finished."

loop do
  print "Enter product code (or 'done'): "
  input = gets.chomp.upcase
  break if input == 'DONE'

  begin
    basket.add(input)
    puts "Added #{input} to basket."
  rescue ArgumentError => e
    puts "Error: #{e.message}"
  end
end

total = basket.total
puts "\nBasket Total: $#{'%.2f' % total}"
