## Customer Analytics

require "spec_helper"

RSpec.describe "Iteration 5" do
  let(:sales_analyst) { SalesAnalyst.new(engine) }

  context "Sales Analyst - Customer Repository" do
    it "#top_buyers returns the top x customers that spent the most money" do
      x = 5
      expected = sales_analyst.top_buyers(5)

      expect(expected.length).to eq 5
      expect(expected.first.id).to eq 313
      expect(expected.last.id).to eq 478

      expected.each { |c| expect(c.class).to eq Customer }
    end

    it "#top_buyers returns the top 20 customers by default if no number is given" do
      expected = sales_analyst.top_buyers

      expect(expected.length).to eq 20
      expect(expected.first.id).to eq 313
      expect(expected.last.id).to eq 250

      expected.each { |c| expect(c.class).to eq Customer }
    end

    it "#top_merchant_for_customer returns the favorite merchant for given customer" do
      customer_id = 100
      expected = sales_analyst.top_merchant_for_customer(customer_id)

      expect(expected.class).to eq Merchant
      expect(expected.id).to eq 12336753
    end

    it "#one_time_buyers returns customers with only one invoice" do
      expected = sales_analyst.one_time_buyers

      expect(expected.length).to eq 150
      expect(expected.first.fully_paid_invoices.length).to eq 1
      expect(expected.first.class).to eq Customer
    end

    it "#one_time_buyers_item returns the items which most one_time_buyers bought" do
      expected = sales_analyst.one_time_buyers_item

      expect(expected.length).to eq 1

      expect(expected.first.id).to eq 263519844
      expect(expected.first.class).to eq Item
    end

    it "#most_recently_bought_items returns the items which the given customer bought most recently" do
      customer_id = 400
      expected = sales_analyst.most_recently_bought_items(customer_id)

      expect(expected.length).to eq 3
      expect(expected.first.id).to eq 263549078
      expect(expected.first.name).to eq "Stone of Magic"
      expect(expected.first.class).to eq Item

      customer_id = 890
      expected = sales_analyst.most_recently_bought_items(customer_id)

      expect(expected.length).to eq 7
      expect(expected.first.id).to eq 263516596
      expect(expected.first.name).to eq "Multilayer Tulle Skirt, Bridal Skirt"
      expect(expected.first.class).to eq Item
    end

    it "#customers_with_unpaid_invoices returns customers with unpaid invoices" do
      expected = sales_analyst.customers_with_unpaid_invoices

      expect(expected.length).to eq 786
      expect(expected.first.id).to eq 1
      expect(expected.last.id).to eq 999
      expect(expected.first.class).to eq Customer
    end

    it "#best_invoice_by_revenue returns the invoice with the highest dollar amount" do
      expected = sales_analyst.best_invoice_by_revenue

      expect(expected.id).to eq 3394
      expect(expected.total).to eq 47877.97
      expect(expected.class).to eq Invoice
    end

    it "#best_invoice_by_quantity returns the invoice with the highest item count" do
      expected = sales_analyst.best_invoice_by_quantity
      highest_quantity = expected.invoice_items.map(&:quantity).reduce(:+)

      expect(expected.id).to eq 1281
      expect(highest_quantity).to eq 64
      expect(expected.class).to eq Invoice
    end
  end
end
