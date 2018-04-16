## Customer Analytics

require "spec_helper"

RSpec.describe "iteration 5" do
  let(:sales_analyst) { engine.analyst }

  context "sales analyst - customer repository" do
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

      expect(expected.length).to eq 76
      expect(engine.invoices.find_all_by_customer_id(expected.first.id).length).to eq 1
      expect(expected.first.class).to eq Customer
    end

    it "#one_time_buyers_top_item returns the item bought by one time buyers in the highest quantity" do
      expected = sales_analyst.one_time_buyers_top_item

      expect(expected.id).to eq 263396463
      expect(expected.class).to eq Item
    end

    it "#items_bought_in_year returns the items which the given customer bought in the given year" do
      customer_id = 400
      year = 2000
      expected = sales_analyst.items_bought_in_year(customer_id, year)

      expect(expected.length).to eq 0
      expect(expected.class).to eq Array

      customer_id = 400
      year = 2002
      expected = sales_analyst.items_bought_in_year(customer_id, year)

      expect(expected.length).to eq 2
      expect(expected.first.id).to eq 263549742
      expect(expected.first.name).to eq "Necklace: V Tube"
      expect(expected.first.class).to eq Item
    end

    it "#highest_volume_items returns an array of the item(s) purchased the most times by a customer" do
      expected = sales_analyst.highest_volume_items(200)

      expect(expected.length).to eq 6
      expect(expected.first.id).to eq 263420195
      expect(expected.last.id).to eq 263448547
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
      expect(expected.class).to eq Invoice
    end

    it "#best_invoice_by_quantity returns the invoice with the highest item count" do
      expected = sales_analyst.best_invoice_by_quantity

      expect(expected.id).to eq 1281
      expect(expected.class).to eq Invoice
    end
  end
end
