require "spec_helper"

RSpec.describe "SalesAnalyst" do
  context "Analysis" do
    let(:sales_analyst) { SalesAnalyst.new(engine) }

    it "#average_items_per_merchant returns average items per merchant" do
      expected = sales_analyst.average_items_per_merchant

      expect(expected).to eq 2.87
      expect(expected.class).to eq Float
    end

    it "#average_items_per_merchant_standard_deviation returns the standard deviation" do
      expected = sales_analyst.average_items_per_merchant_standard_deviation

      expect(expected).to eq 3.26
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

      expect(expected).to eq 16.66
      expect(expected.class).to eq BigDecimal
    end

    it "#average_price_per_merchant returns the average price for all merchants" do
      expected = sales_analyst.average_price_per_merchant

      expect(expected).to eq 251.06
      expect(expected.class).to eq BigDecimal
    end

    it "#golden_items returns items that are two standard deviations above the average price" do
      expected = sales_analyst.golden_items

      expect(expected.length).to eq 5
      expect(expected.first.class).to eq Item
    end
  end
end
