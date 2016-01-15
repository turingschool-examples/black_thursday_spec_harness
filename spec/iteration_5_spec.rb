## Merchant/Customer Analytics

require "spec_helper"

RSpec.describe "Iteration 5" do
  let(:sales_analyst) { SalesAnalyst.new(engine) }

  context "Merchant" do
    let(:merchant) { engine.merchants.find_by_id(12335523) }

    it "merchant#revenue_by_merchant returns the revenue for given merchant" do
      expected = sales_analyst.revenue_by_merchant(12334194)

      expect(expected).to eq 17292.25
      expect(expected.class).to eq Float
    end
  end
end
