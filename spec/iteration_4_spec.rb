## Merchant (and some Customer) Analytics

require "spec_helper"

RSpec.describe "Iteration 4" do
  let(:sales_analyst) { SalesAnalyst.new(engine) }

  context "Sales Analyst" do
    it "#merchant_revenue_by_date(date)" do
      date = Time.parse("2011-02-27")
      expected = sales_analyst.merchant_revenue_by_date(date)

      expect(expected.length).to eq 4
      expect(expected.first.class).to eq Merchant
    end

    it "#top_revenue_earners(x) returns the top x merchants ranked by revenue" do
      expected = sales_analyst.top_revenue_earners(10)
      first = expected.first.revenue
      last = expected.last.revenue

      expect(expected.length).to eq 10

      expect(expected.first.class).to eq Merchant
      expect(expected.first.id).to eq 12335938

      expect(expected.last.class).to eq Merchant
      expect(expected.last.id).to eq 12334280
    end

    it "#top_revenue_earners returns by default the top 20 merchants ranked by revenue if no argument is given" do
      expected = sales_analyst.top_revenue_earners
      first = expected.first
      last = expected.last

      expect(expected.length).to eq 20

      expect(first.class).to eq Merchant
      expect(first.id).to eq 12335938

      expect(last.class).to eq Merchant
      expect(last.id).to eq 12334257
    end

    it "#merchants_ranked_by_revenue returns the merchants ranked by total revenue" do
      expected = sales_analyst.merchants_ranked_by_revenue

      expect(expected.first.class).to eq Merchant
      expect(expected.first.id).to eq 12335938

      expect(expected.last.id).to eq 12334235
    end
  end
end
