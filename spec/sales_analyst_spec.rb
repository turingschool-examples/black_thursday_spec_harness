require "spec_helper"

RSpec.describe "SalesAnalyst" do
  context "Analysis" do
    it "#average_items_per_merchant returns average items per merchant" do
      sales_analyst = SalesAnalyst.new(engine)
      expected = sales_analyst.average_items_per_merchant

      expect(expected).to eq 2.87
    end
  end
end
