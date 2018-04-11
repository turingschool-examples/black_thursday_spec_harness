## Iteration 1 - Starting Relationships and Business Intelligence

require "spec_helper"

RSpec.describe "Iteration 1" do
  context "Sales Analyst" do
    let(:sales_analyst) { engine.analyst }

    it "#average_items_per_merchant returns average items per merchant" do
      expected = sales_analyst.average_items_per_merchant

      expect(expected).to eq 2.88
      expect(expected.class).to eq Float
    end

    it "#average_items_per_merchant_standard_deviation returns the standard deviation" do
      expected = sales_analyst.average_items_per_merchant_standard_deviation

      expect(expected).to eq 3.26
      expect(expected.class).to eq Float
    end
    it "#merchants_with_high_item_count returns merchants more than one standard deviation above the average number of products offered" do
      expected = sales_analyst.merchants_with_high_item_count

      expect(expected.length).to eq 52
      expect(expected.first.class).to eq Merchant
    end

    it "#average_item_price_for_merchant returns the average item price for the given merchant" do
      merchant_id = 12334105
      expected = sales_analyst.average_item_price_for_merchant(merchant_id)

      expect(expected).to eq 16.66
      expect(expected.class).to eq BigDecimal
    end

    it "#average_average_price_per_merchant returns the average price for all merchants" do
      expected = sales_analyst.average_average_price_per_merchant

      expect(expected).to eq 350.29
      expect(expected.class).to eq BigDecimal
    end

    it "#golden_items returns items that are two standard deviations above the average price" do
      expected = sales_analyst.golden_items

      expect(expected.length).to eq 5
      expect(expected.first.class).to eq Item
    end
  end
end
