require "spec_helper"

RSpec.describe "Items" do
  context "Item" do
    it "#id returns the id" do
      item_one = engine.item_repository.items.first
      expect(item_one.id).to eq 263395237

      item_two = engine.item_repository.items.last
      expect(item_two.id).to eq 263567474
    end

    it "#name returns the name" do
      item_one = engine.item_repository.items.first
      expect(item_one.name).to eq "510+ RealPush Icon Set"

      item_two = engine.item_repository.items.last
      expect(item_two.name).to eq "Minty Green Knit Crochet Infinity Scarf"
    end

    it "#description returns the description" do
      item_one = engine.item_repository.items.first

      expect(item_one.description.class).to eq String
      expect(item_one.description.length).to eq 2237
    end

    it "#unit_price returns the unit price" do
      item_one = engine.item_repository.items.first

      expect(item_one.unit_price).to eq 1200
      expect(item_one.unit_price.class).to eq BigDecimal
    end

    it "#created_at returns the Time the item was created" do
      item_one = engine.item_repository.items.first

      expect(item_one.created_at).to eq Time.new("2016-01-01 00:00:00 -0700")
      expect(item_one.created_at.class).to eq Time
    end

    it "#updated_at returns the Time the item was last updated" do
      item_one = engine.item_repository.items.first

      expect(item_one.updated_at).to eq Time.new("2007-01-01 00:00:00 -0700")
      expect(item_one.updated_at.class).to eq Time
    end
  end

  context "Item Repository" do
    it "#all returns all items" do
      expected = engine.item_repository.all

      expect(expected.length).to eq 1367
    end

    it "#find_by_id finds an item by id" do
      id = 263538760
      expected = engine.item_repository.find_by_id(id)

      expect(expected.id).to eq id
      expect(expected.name).to eq "Puppy blankie"
    end

    it "#find_by_name finds an item by name" do
      name = "Puppy blankie"
      expected = engine.item_repository.find_by_name(name)

      expect(expected.name).to eq name
      expect(expected.id).to eq 263538760
    end
  end
end
