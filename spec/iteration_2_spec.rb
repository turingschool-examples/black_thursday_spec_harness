## Iteration 2 - Basic Invoices

require "spec_helper"

RSpec.describe "Iteration 2" do
  context "Invoices" do
    it "#all returns all invoices" do
      expected = engine.invoices.all

      expect(expected.length).to eq 4985
    end

    it "#find_by_id returns an invoice associated to the given id" do
      invoice_id = 3452
      expected = engine.invoices.find_by_id(invoice_id)

      expect(expected.id).to eq invoice_id
      expect(expected.merchant_id).to eq 12335690
      expect(expected.customer_id).to eq 679
      expect(expected.status).to eq :pending

      invoice_id = 5000
      expected = engine.invoices.find_by_id(invoice_id)

      expect(expected).to eq nil
    end

    it "#find_all_by_customer_id returns all invoices associated with given customer" do
      customer_id = 300
      expected = engine.invoices.find_all_by_customer_id(customer_id)

      expect(expected.length).to eq 10

      customer_id = 1000
      expected = engine.invoices.find_all_by_customer_id(customer_id)

      expect(expected).to eq []
    end

    it "#find_all_by_merchant_id returns all invoices associated with given merchant" do
      merchant_id = 12335080
      expected = engine.invoices.find_all_by_merchant_id(merchant_id)

      expect(expected.length).to eq 7

      merchant_id = 1000
      expected = engine.invoices.find_all_by_merchant_id(merchant_id)

      expect(expected).to eq []
    end

    it "#find_all_by_status returns all invoices associated with given status" do
      status = :shipped
      expected = engine.invoices.find_all_by_status(status)

      expect(expected.length).to eq 2839

      status = :pending
      expected = engine.invoices.find_all_by_status(status)

      expect(expected.length).to eq 1473

      status = :sold
      expected = engine.invoices.find_all_by_status(status)

      expect(expected).to eq []
    end
  end

  context "Invoice" do
    let(:invoice) { engine.invoices.find_by_id(3452) }

    it "#id returns the invoice id" do
      expect(invoice.id).to eq 3452
      expect(invoice.id.class).to eq Fixnum
    end

    it "#customer_id returns the invoice customer id" do
      expect(invoice.customer_id).to eq 679
      expect(invoice.customer_id.class).to eq Fixnum
    end

    it "#merchant_id returns the invoice merchant id" do
      expect(invoice.merchant_id).to eq 12335690
      expect(invoice.merchant_id.class).to eq Fixnum
    end

    it "#status returns the invoice status" do
      expect(invoice.status).to eq :pending
      expect(invoice.status.class).to eq Symbol
    end

    it "#created_at returns a Time instance for the date the invoice was created" do
      expect(invoice.created_at).to eq Time.parse("2015-07-10 00:00:00 -0600")
      expect(invoice.created_at.class).to eq Time
    end

    it "#updated_at returns a Time instance for the date the invoice was last updated" do
      expect(invoice.updated_at).to eq Time.parse("2015-12-10 00:00:00 -0700")
      expect(invoice.updated_at.class).to eq Time
    end

    it "#merchant returns the associated merchant" do
      expected = invoice.merchant

      expect(expected.class).to eq Merchant
      expect(expected.id).to eq 12335690
    end
  end

  context "Merchants" do
    it "#invoices returns invoices associated with given merchant" do
      merchant = engine.merchants.find_by_id(12335690)
      expected = merchant.invoices

      expect(expected.length).to eq 16
      expect(expected.first.class).to eq Invoice

      merchant = engine.merchants.find_by_id(12334189)
      expected = merchant.invoices

      expect(expected.length).to eq 10
      expect(expected.first.class).to eq Invoice
    end
  end

  context "SalesAnalyst" do
    let(:sales_analyst) { SalesAnalyst.new(engine) }

    it "#average_invoices_per_merchant returns average number of invoices per merchant" do
      expected = sales_analyst.average_invoices_per_merchant

      expect(expected).to eq 10.47
      expect(expected.class).to eq Float
    end

    it "#average_invoices_per_merchant_standard_deviation returns the standard deviation" do
      expected = sales_analyst.average_invoices_per_merchant_standard_deviation

      expect(expected).to eq 3.32
      expect(expected.class).to eq Float
    end

    it "#top_merchants_by_invoice_count returns merchants that are two standard deviations above the mean" do
      expected = sales_analyst.top_merchants_by_invoice_count

      expect(expected.length).to eq 12
      expect(expected.first.class).to eq Merchant
    end

    it "#bottom_merchants_by_invoice_count returns merchants that are two standard deviations below the mean" do
      expected = sales_analyst.bottom_merchants_by_invoice_count

      expect(expected.length).to eq 5
      expect(expected.first.class).to eq Merchant
    end

    it "#top_days_by_invoice_count returns invoices with an invoice item count more than two standard deviations above the mean" do
      expected = sales_analyst.top_days_by_invoice_count

      expect(expected.length).to eq 1
      expect(expected.first.class).to eq Symbol
    end

    it "#invoice_status returns the percentage of invoices with given status" do
      expected = sales_analyst.invoice_status(:pending)

      expect(expected).to eq 29.5

      expected = sales_analyst.invoice_status(:shipped)

      expect(expected).to eq 56.95

      expected = sales_analyst.invoice_status(:returned)

      expect(expected).to eq 13.5
    end
  end
end
