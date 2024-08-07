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

# Get user input for offers
puts "Enter offers."
offers = []
loop do
  print "Enter product code (or press enter to finish): "
  product_code = gets.chomp

  break if product_code.empty?

  print "Enter quantity: "
  quantity = gets.chomp.to_i

  print "Enter discount percentage: "
  discount_percentage = gets.chomp.to_i

  offers << Offer.new(product_code, quantity, discount_percentage)
  puts "Added offer: buy #{quantity} #{product_code}, get #{discount_percentage}% off"
end

offers = [
  Offer.new('R01', 2, 50) # buy one red widget, get the second half price
] if offers.empty?

# Create a new basket
basket = Basket.new(catalog, delivery_rules, offers)
puts "-------------------------------------------------------------------------" #seprate for Acme Widget Co Basket System!
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