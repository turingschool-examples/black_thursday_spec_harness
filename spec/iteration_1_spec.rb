## Iteration 1 - Starting Relationships and Business Intelligence

require "spec_helper"

RSpec.describe "Iteration 1" do
  context "Merchants" do
    it "#items returns associated items" do
      id = 12335971
      merchant = engine.merchants.find_by_id(id)
      expected = merchant.items

      expect(expected.length).to eq 1
    end
  end

  context "Items" do
    it "#merchant returns the associated merchant" do
      id = 263538760
      item = engine.items.find_by_id(id)
      expected = item.merchant

      expect(expected.id).to eq item.merchant_id
      expect(expected.name).to eq "Blankiesandfriends"

      id = 263421679
      item = engine.items.find_by_id(id)
      expected = item.merchant

      expect(expected.id).to eq item.merchant_id
      expect(expected.name).to eq "Chemisonodimenticato"
    end
  end

  context "Sales Analyst" do
    let(:sales_analyst) { SalesAnalyst.new(engine) }

    it "#average_items_per_merchant returns average items per merchant" do
      expected = sales_analyst.average_items_per_merchant

      expect(expected).to eq 2.87
      expect(expected.class).to eq Float
    end

    it "#average_items_per_merchant_standard_deviation returns the standard deviation" do
      expected = sales_analyst.average_items_per_merchant_standard_deviation
      expect(expected).to eq 3.25
      expect(expected.class).to eq Float
    end
    it "#merchants_with_low_item_count returns merchants more than one standard deviation below the average number of products offered" do
      expected = sales_analyst.merchants_with_low_item_count
      expect(expected.length).to eq 52
      expect(expected.first.class).to eq Merchant
    end

    it "#average_item_price_for_merchant returns the average item price for the given merchant" do
      merchant_id = 12334105
      expected = sales_analyst.average_item_price_for_merchant(merchant_id)

      expect(expected).to eq 1665.67
      expect(expected.class).to eq BigDecimal
    end

    it "#average_price_per_merchant returns the average price for all merchants" do
      expected = sales_analyst.average_price_per_merchant

      expect(expected).to eq 25105.51
      expect(expected.class).to eq BigDecimal
    end

    it "#golden_items returns items that are two standard deviations above the average price" do
      expected = sales_analyst.golden_items

      expect(expected.length).to eq 5
      expect(expected.first.class).to eq Item
    end
  end
end
