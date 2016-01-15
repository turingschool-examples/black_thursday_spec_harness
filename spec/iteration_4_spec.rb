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

    it "#top_percent(xx) returns the top xx percent of the collection" do
      top_revenue_earners = sales_analyst.top_revenue_earners
      expected = sales_analyst.top_percent(top_revenue_earners, 0.5)

      expect(expected.length).to eq 10

      top_revenue_earners = sales_analyst.top_revenue_earners(100)
      expected = sales_analyst.top_percent(top_revenue_earners, 0.1)

      expect(expected.length).to eq 10

      top_revenue_earners = sales_analyst.top_revenue_earners(90)
      expected = sales_analyst.top_percent(top_revenue_earners, 0.15)

      expect(expected.length).to eq 14

      top_revenue_earners = sales_analyst.top_revenue_earners(76)
      expected = sales_analyst.top_percent(top_revenue_earners, 0.14)

      expect(expected.length).to eq 11
    end

    it "#by_month(month) filters the collection by month" do
      top_revenue_earners = sales_analyst.top_revenue_earners(100)
      expected = sales_analyst.by_month(top_revenue_earners, "January")

      expect(expected.length).to eq 12

      ranked_by_revenue = sales_analyst.merchants_ranked_by_revenue
      expected = sales_analyst.by_month(ranked_by_revenue, "February")

      expect(expected.length).to eq 40

      ranked_by_revenue = sales_analyst.merchants_ranked_by_revenue
      expected = sales_analyst.by_month(top_revenue_earners, "March")

      expect(expected.length).to eq 7
    end
  end
end
