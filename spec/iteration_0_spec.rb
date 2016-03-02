## Iteration 0 - Merchants & Items

require "spec_helper"

RSpec.describe "Iteration 0" do
  context "Merchant Repository" do
    it "#all returns an array of all merchant instances" do
      expected = engine.merchants.all
      expect(expected.count).to eq 475
    end

    it "#find_by_id finds a merchant by id" do
      id = 12335971
      expected = engine.merchants.find_by_id(id)

      expect(expected.id).to eq 12335971
      expect(expected.name).to eq "ivegreenleaves"
    end

    it "#find_by_id returns nil if the merchant does not exist" do
      id = 101
      expected = engine.merchants.find_by_id(id)

      expect(expected).to eq nil
    end

    it "#find_by_name finds the first matching merchant by name" do
      name = "leaburrot"
      expected = engine.merchants.find_by_name(name)

      expect(expected.id).to eq 12334411
      expect(expected.name).to eq name
    end

    it "#find_by_name is a case insensitive search" do
      name = "LEABURROT"
      expected = engine.merchants.find_by_name(name)

      expect(expected.id).to eq 12334411

      name = "leaburrot"
      expected = engine.merchants.find_by_name(name)

      expect(expected.id).to eq 12334411
    end

    it "#find_by_name returns nil if the merchant does not exist" do
      name = "Turing School of Software and Design"
      expected = engine.merchants.find_by_name(name)

      expect(expected).to eq nil
    end

    it "#find_all_by_name finds all merchants matching the given name fragment" do
      fragment = "style"
      expected = engine.merchants.find_all_by_name(fragment)

      expect(expected.length).to eq 3
      expect(expected.map(&:name).include?("justMstyle")).to eq true
      expect(expected.map(&:id).include?(12337211)).to eq true
    end

    it "#find_all_by_name returns an empty array if there are no matches" do
      name = "Turing School of Software and Design"
      expected = engine.merchants.find_all_by_name(name)

      expect(expected.size).to eq 0
    end
  end

  context "Merchant" do
    it "#id returns the merchant id" do
      merchant = engine.merchants.all.first
      expect(merchant.id).to eq 12334105
    end

    it "#name returns the merchant name" do
      merchant_one = engine.merchants.all.first
      expect(merchant_one.name).to eq "Shopin1901"

      merchant_two = engine.merchants.all.last
      expect(merchant_two.name).to eq "CJsDecor"
    end
  end

  context "Item Repository" do
    it "#all returns all items" do
      expected = engine.items.all

      expect(expected.length).to eq 1367
    end

    it "#find_by_id finds an item by id" do
      id = 263538760
      expected = engine.items.find_by_id(id)

      expect(expected.id).to eq id
      expect(expected.name).to eq "Puppy blankie"

      id = 1
      expected = engine.items.find_by_id(id)

      expect(expected).to eq nil
    end

    it "#find_by_name finds an item by name" do
      name = "Puppy blankie"
      expected = engine.items.find_by_name(name)

      expect(expected.name).to eq name
      expect(expected.id).to eq 263538760

      name = "Sales Engine"
      expected = engine.items.find_by_name(name)

      expect(expected).to eq nil
    end

    it "#find_all_with_description finds all items matching given description" do
      description = "A large Yeti of sorts, casually devours a cow as the others watch numbly."
      expected = engine.items.find_all_with_description(description)

      expect(expected.first.description).to eq description
      expect(expected.first.id).to eq 263550472

      description = "A LARGE yeti of SOrtS, casually devoURS a COw as the OTHERS WaTch NUmbly."
      expected = engine.items.find_all_with_description(description)

      expect(expected.first.id).to eq 263550472

      description = "Sales Engine is a relational database"
      expected = engine.items.find_all_with_description(description)

      expect(expected.length).to eq 0
    end

    it "#find_all_by_price finds all items matching given price" do
      price = BigDecimal.new(25)
      expected = engine.items.find_all_by_price(price)

      expect(expected.length).to eq 79

      price = BigDecimal.new(10)
      expected = engine.items.find_all_by_price(price)

      expect(expected.length).to eq 63

      price = BigDecimal.new(20000)
      expected = engine.items.find_all_by_price(price)

      expect(expected.length).to eq 0
    end

    it "#find_all_by_price_in_range returns an array of items priced within given range" do
      range = (1000.00..1500.00)
      expected = engine.items.find_all_by_price_in_range(range)

      expect(expected.length).to eq 19

      range = (10.00..150.00)
      expected = engine.items.find_all_by_price_in_range(range)

      expect(expected.length).to eq 910

      range = (10.00..15.00)
      expected = engine.items.find_all_by_price_in_range(range)

      expect(expected.length).to eq 205

      range = (0..10.0)
      expected = engine.items.find_all_by_price_in_range(range)

      expect(expected.length).to eq 302
    end

    it "#find_all_by_merchant_id returns an array of items associated with given merchant id" do
      merchant_id = 12334326
      expected = engine.items.find_all_by_merchant_id(merchant_id)

      expect(expected.length).to eq 6

      merchant_id = 12336020
      expected = engine.items.find_all_by_merchant_id(merchant_id)

      expect(expected.length).to eq 2
    end
  end

  context "Item" do
    it "#id returns the id" do
      item_one = engine.items.all.first
      expect(item_one.id).to eq 263395237

      item_two = engine.items.all.last
      expect(item_two.id).to eq 263567474
    end

    it "#name returns the name" do
      item_one = engine.items.all.first
      expect(item_one.name).to eq "510+ RealPush Icon Set"

      item_two = engine.items.all.last
      expect(item_two.name).to eq "Minty Green Knit Crochet Infinity Scarf"
    end

    it "#description returns the description" do
      item_one = engine.items.all.first

      expect(item_one.description.class).to eq String
      expect(item_one.description.length).to eq 2236
    end

    it "#unit_price returns the unit price" do
      item_one = engine.items.all.first

      expect(item_one.unit_price).to eq 12.00
      expect(item_one.unit_price.class).to eq BigDecimal
    end

    it "#created_at returns the Time the item was created" do
      item_one = engine.items.all.first

      expect(item_one.created_at).to eq Time.parse("2016-01-11 09:34:06 UTC")
      expect(item_one.created_at.class).to eq Time
    end

    it "#updated_at returns the Time the item was last updated" do
      item_one = engine.items.all.first

      expect(item_one.updated_at).to eq Time.parse("2007-06-04 21:35:10 UTC")
      expect(item_one.updated_at.class).to eq Time
    end
  end
end
