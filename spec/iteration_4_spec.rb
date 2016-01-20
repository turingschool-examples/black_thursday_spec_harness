## Merchant Analytics

require "spec_helper"

RSpec.describe "Iteration 4" do

  let(:sales_analyst) { SalesAnalyst.new(engine) }
  let(:merchant) { engine.merchants.find_by_id(12335523) }

  context "Sales Analyst - Merchant Repository" do
    it "#total_revenue_by_date returns total revenue for given date" do
      date = Time.parse("2009-02-07")
      expected = sales_analyst.total_revenue_by_date(date)

      expect(expected).to eq 21067.77
      expect(expected.class).to eq BigDecimal
    end

    it "#top_revenue_earners(x) returns the top x merchants ranked by revenue" do
      expected = sales_analyst.top_revenue_earners(10)
      first = expected.first
      last = expected.last

      expect(expected.length).to eq 10

      expect(first.class).to eq Merchant
      expect(first.id).to eq 12334634

      expect(last.class).to eq Merchant
      expect(last.id).to eq 12335747
    end

    it "#top_revenue_earners returns by default the top 20 merchants ranked by revenue if no argument is given" do
      expected = sales_analyst.top_revenue_earners
      first = expected.first
      last = expected.last

      expect(expected.length).to eq 20

      expect(first.class).to eq Merchant
      expect(first.id).to eq 12334634

      expect(last.class).to eq Merchant
      expect(last.id).to eq 12334159
    end

    it "#merchants_ranked_by_revenue returns the merchants ranked by total revenue" do
      expected = sales_analyst.merchants_ranked_by_revenue

      expect(expected.first.class).to eq Merchant
      expect(expected.first.id).to eq 12334634

      expect(expected.last.id).to eq 12334193
    end

    it "#merchants_with_pending_invoices returns merchants with pending invoices" do
      expected = sales_analyst.merchants_with_pending_invoices

      expect(expected.length).to eq 9
      expect(expected.first.class).to eq Merchant
    end

    it "#merchants_with_only_one_item returns merchants with only one item" do
      expected = sales_analyst.merchants_with_only_one_item

      expect(expected.length).to eq 243
      expect(expected.first.class).to eq Merchant
    end

    it "#merchants_with_only_one_item_registered_in_month returns merchants with only one invoice in given month" do
      expected = sales_analyst.merchants_with_only_one_item_registered_in_month("March")

      expect(expected.length).to eq 21
      expect(expected.first.class).to eq Merchant

      expected = sales_analyst.merchants_with_only_one_item_registered_in_month("June")

      expect(expected.length).to eq 18
      expect(expected.first.class).to eq Merchant
    end

    it "#revenue_by_merchant returns the revenue for given merchant" do
      expected = sales_analyst.revenue_by_merchant(12334194)

      expect(expected).to eq BigDecimal.new(expected)
      expect(expected.class).to eq BigDecimal
    end

    it "#most_sold_item_for_merchant returns the most sold item" do
      merchant_id = 12334189
      expected = sales_analyst.most_sold_item_for_merchant(merchant_id)
      require "pry"; binding.pry
      expect(expected.length).to eq 1

      # expect(expected.first.id).to eq 263446647
      expect(expected.first.name).to eq "Stirling Silver Filigree Drop Hoop Earrings"
      expect(expected.first.class).to eq Item

      merchant_id = 12334768
      expected = sales_analyst.most_sold_item_for_merchant(merchant_id)

      expect(expected.length).to eq 8

      merchant_id = 12337105
      expected = sales_analyst.most_sold_item_for_merchant(merchant_id)

      expect(expected.length).to eq 6
    end

    it "#best_item_for_merchant returns the item which generated most revenue for the given merchant" do
      merchant_id = 12334189
      expected = sales_analyst.best_item_for_merchant(merchant_id)

      expect(expected.id).to eq 263516130
      expect(expected.class).to eq Item

      merchant_id = 12337105
      expected = sales_analyst.best_item_for_merchant(merchant_id)

      expect(expected.id).to eq 263553624
      expect(expected.class).to eq Item
    end
  end
end
