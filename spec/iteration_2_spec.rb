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
      expect(expected.status).to eq "pending"

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
      status = "shipped"
      expected = engine.invoices.find_all_by_status(status)

      expect(expected.length).to eq 2839

      status = "pending"
      expected = engine.invoices.find_all_by_status(status)

      expect(expected.length).to eq 1473

      status = "sold"
      expected = engine.invoices.find_all_by_status(status)

      expect(expected).to eq []
    end
  end
end
