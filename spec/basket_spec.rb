# frozen_string_literal: true

require 'spec_helper'
require 'simplecov'
require_relative '../lib/basket'
require_relative '../lib/product'
require_relative '../lib/catalog'
require_relative '../lib/delivery_rule'
require_relative '../lib/offer'
SimpleCov.start

RSpec.describe Basket do
  let(:catalog) do
    Catalog.new([
      Product.new('R01', 'Red Widget', 32.95),
      Product.new('G01', 'Green Widget', 24.95),
      Product.new('B01', 'Blue Widget', 7.95)
    ])
  end

  let(:delivery_rules) do
    [
      DeliveryRule.new(90, 0),
      DeliveryRule.new(50, 2.95),
      DeliveryRule.new(0, 4.95)
    ]
  end

  let(:offers) do
    [
      Offer.new('R01', 2, 50)
    ]
  end

  subject(:basket) { described_class.new(catalog, delivery_rules, offers) }

  describe '#add' do
    it 'adds a product to the basket' do
      expect { basket.add('R01') }.not_to raise_error
    end

    it 'raises an error for invalid product code' do
      expect { basket.add('X01') }.to raise_error(ArgumentError)
    end
  end

  describe '#total' do
    it 'calculates the total for B01, G01' do
      basket.add('B01')
      basket.add('G01')
      expect(basket.total).to be_within(0.01).of(37.85)
    end

    it 'calculates the total for R01, R01' do
      basket.add('R01')
      basket.add('R01')
      expect(basket.total).to be_within(0.01).of(54.37)
    end

    it 'calculates the total for R01, G01' do
      basket.add('R01')
      basket.add('G01')
      expect(basket.total).to be_within(0.01).of(60.85)
    end

    it 'calculates the total for B01, B01, R01, R01, R01' do
      basket.add('B01')
      basket.add('B01')
      basket.add('R01')
      basket.add('R01')
      basket.add('R01')
      expect(basket.total).to be_within(0.01).of(98.27)
    end
  end
end
