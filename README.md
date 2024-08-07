# Acme Widget Co Basket System

This project implements a basket system for Acme Widget Co, allowing for product management, delivery charge calculation, and special offer application.

## Requirements

- Ruby 3.2.2
- Docker (optional)

## Setup

1. Clone the repository
2. Run `bundle install` to install dependencies

## Adding data to Basket

For add items on basket from input

```
ruby run_basket.rb
```
Alternatively, if you're using Docker:

```
docker-compose up
```

## Running Tests

To run the tests, use the following command:

```
bundle exec rspec
```

Alternatively, if you're using Docker:

```
docker-compose up
```

## Implementation Details

This implementation uses a modular approach with separate classes for different concerns:

- `Product`: Represents a product with a code, name, and price
- `Catalog`: Manages the product catalog
- `DeliveryRule`: Defines a delivery charge rule
- `Offer`: Implements a special offer
- `Basket`: The main class that manages the shopping basket

The `Basket` class uses dependency injection to receive the catalog, delivery rules, and offers, allowing for easy modification and testing of different scenarios.

## Assumptions

- Product codes are unique
- Delivery charges are calculated based on the total after discounts
- Only one type of offer (buy one, get second half price) is implemented, but the system is designed to be easily extendable for other types of offers

## Future Improvements

- Implement a factory pattern for creating different types of offers
- Add more comprehensive error handling and logging
- Implement a caching mechanism for frequently accessed products or calculations