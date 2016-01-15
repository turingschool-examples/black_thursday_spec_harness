## Iteration 3 - Item Sales

require "spec_helper"

RSpec.describe "Iteration 3" do
  context "Invoice Items" do
    it "#all returns an array of all invoice item instances" do
      expected = engine.invoice_items.all
      expect(expected.count).to eq 21830
    end

    it "#find_by_id finds an invoice_item by id" do
      id = 10
      expected = engine.invoice_items.find_by_id(id)

      expect(expected.id).to eq id
      expect(expected.item_id).to eq 263523644
      expect(expected.invoice_id).to eq 2
    end

    it "#find_by_id returns nil if the invoice item does not exist" do
      id = 200000
      expected = engine.invoice_items.find_by_id(id)

      expect(expected).to eq nil
    end

    it "#find_all_by_item_id finds all items matching given item_id" do
      item_id = 263408101
      expected = engine.invoice_items.find_all_by_item_id(item_id)

      expect(expected.length).to eq 11
      expect(expected.first.class).to eq InvoiceItem
    end

    it "#find_all_by_item_id returns an empty array if there are no matches" do
      item_id = 10
      expected = engine.invoice_items.find_all_by_item_id(item_id)

      expect(expected.length).to eq 0
      expect(expected.empty?).to eq true
    end

    it "#find_all_by_invoice_id finds all items matching given item_id" do
      invoice_id = 100
      expected = engine.invoice_items.find_all_by_invoice_id(invoice_id)

      expect(expected.length).to eq 3
      expect(expected.first.class).to eq InvoiceItem
    end

    it "#find_all_by_invoice_id returns an empty array if there are no matches" do
      invoice_id = 1234567890
      expected = engine.invoice_items.find_all_by_invoice_id(invoice_id)

      expect(expected.length).to eq 0
      expect(expected.empty?).to eq true
    end
  end

  context "Invoice Item" do
    let(:invoice_item) { engine.invoice_items.find_by_id(2345) }

    it "#id returns the invoice item id" do
      expect(invoice_item.id).to eq 2345
      expect(invoice_item.id.class).to eq Fixnum
    end

    it "#item_id returns the item id" do
      expect(invoice_item.item_id).to eq 263562118
      expect(invoice_item.item_id.class).to eq Fixnum
    end

    it "#invoice_id returns the invoice id" do
      expect(invoice_item.invoice_id).to eq 522
      expect(invoice_item.invoice_id.class).to eq Fixnum
    end

    it "#unit_price returns the unit price" do
      expect(invoice_item.unit_price).to eq 84787.0
      expect(invoice_item.unit_price.class).to eq BigDecimal
    end

    it "#unit_price_to_dollars returns the unit price in terms of dollars" do
      expect(invoice_item.unit_price_to_dollars).to eq 847.87
      expect(invoice_item.unit_price_to_dollars.class).to eq Float
    end

    it "#created_at returns a Time instance for the date the invoice item was created" do
      expect(invoice_item.created_at).to eq Time.parse("2012-03-27 14:54:35 UTC")
      expect(invoice_item.created_at.class).to eq Time
    end

    it "#updated_at returns a Time instance for the date the invoice item was last updated" do
      expect(invoice_item.updated_at).to eq Time.parse("2012-03-27 14:54:35 UTC")
      expect(invoice_item.updated_at.class).to eq Time
    end
  end

  context "Transactions" do
    it "#all returns all transactions" do
      expected = engine.transactions.all
      expect(expected.count).to eq 4985
    end

    it "#find_by_id returns a transaction matching the given id" do
      id = 2
      expected = engine.transactions.find_by_id(id)

      expect(expected.id).to eq id
      expect(expected.class).to eq Transaction
    end

    it "#find_all_by_invoice_id returns all transactions matching the given id" do
      id = 2179
      expected = engine.transactions.find_all_by_invoice_id(id)

      expect(expected.length).to eq 2
      expect(expected.first.invoice_id).to eq id
      expect(expected.first.class).to eq Transaction

      id = 14560
      expected = engine.transactions.find_all_by_invoice_id(id)
      expect(expected.empty?).to eq true
    end

    it "#find_all_by_credit_card_number returns all transactions matching given credit card number" do
      credit_card_number = 4848466917766329
      expected = engine.transactions.find_all_by_credit_card_number(credit_card_number)

      expect(expected.length).to eq 1
      expect(expected.first.class).to eq Transaction
      expect(expected.first.credit_card_number).to eq credit_card_number

      credit_card_number = 4848466917766328
      expected = engine.transactions.find_all_by_credit_card_number(credit_card_number)

      expect(expected.empty?).to eq true
    end

    it "#find_all_by_result returns all transactions matching given result" do
      result = "success"
      expected = engine.transactions.find_all_by_result(result)

      expect(expected.length).to eq 4158
      expect(expected.first.class).to eq Transaction
      expect(expected.first.result).to eq result

      result = "failed"
      expected = engine.transactions.find_all_by_result(result)

      expect(expected.length).to eq 827
      expect(expected.first.class).to eq Transaction
      expect(expected.first.result).to eq result
    end
  end

  context "Transaction" do
    let(:transaction) { engine.transactions.find_by_id(1) }

    it "#id returns the transaction id" do
      expect(transaction.id).to eq 1
      expect(transaction.id.class).to eq Fixnum
    end

    it "#invoice_id returns the invoice id" do
      expect(transaction.invoice_id).to eq 2179
      expect(transaction.invoice_id.class).to eq Fixnum
    end

    it "#credit_card_number returns the credit card number" do
      expect(transaction.credit_card_number).to eq 4068631943231473
      expect(transaction.credit_card_number.class).to eq Fixnum
    end

    it "#credit_card_expiration_date returns the credit card expiration" do
      expect(transaction.credit_card_expiration_date).to eq "0217"
      expect(transaction.credit_card_expiration_date.class).to eq String
    end

    it "#result returns the result" do
      expect(transaction.result).to eq "success"
      expect(transaction.result.class).to eq String
    end

    it "#created_at returns a Time instance for the date the invoice item was created" do
      expect(transaction.created_at).to eq Time.parse("2012-02-26 20:56:56 UTC")
      expect(transaction.created_at.class).to eq Time
    end

    it "#updated_at returns a Time instance for the date the invoice item was last updated" do
      expect(transaction.updated_at).to eq Time.parse("2012-02-26 20:56:56 UTC")
      expect(transaction.updated_at.class).to eq Time
    end
  end

  context "Customer Repository" do
    it "#all returns all of the customers" do
      expected = engine.customers.all
      expect(expected.length).to eq 1000
      expect(expected.first.class).to eq Customer
    end

    it "#find_by_id returns the customer with matching id" do
      id = 100
      expected = engine.customers.find_by_id(id)

      expect(expected.id).to eq id
      expect(expected.class).to eq Customer
    end

    it "#find_all_by_first_name returns all customers with matching first name" do
      fragment = "oe"
      expected = engine.customers.find_all_by_first_name(fragment)

      expect(expected.length).to eq 8
      expect(expected.first.class).to eq Customer
    end

    it "#find_all_by_last_name returns all customers with matching last name" do
      fragment = "On"
      expected = engine.customers.find_all_by_last_name(fragment)

      expect(expected.length).to eq 85
      expect(expected.first.class).to eq Customer
    end

    it "#find_all_by_first_name and #find_all_by_last_name are case insensitive" do
      fragment = "NN"
      expected = engine.customers.find_all_by_first_name(fragment)

      expect(expected.length).to eq 57
      expect(expected.first.class).to eq Customer

      fragment = "oN"
      expected = engine.customers.find_all_by_last_name(fragment)

      expect(expected.length).to eq 85
      expect(expected.first.class).to eq Customer
    end
  end

  context "Customer" do
    let(:customer) { engine.customers.find_by_id(500) }

    it "#id returns the id" do
      expect(customer.id).to eq 500
      expect(customer.id.class).to eq Fixnum
    end

    it "#first_name returns the first_name" do
      expect(customer.first_name).to eq "Hailey"
      expect(customer.first_name.class).to eq String
    end

    it "#last_name returns the last_name" do
      expect(customer.last_name).to eq "Veum"
      expect(customer.last_name.class).to eq String
    end

    it "#created_at returns a Time instance for the date the invoice item was created" do
      expect(customer.created_at).to eq Time.parse("2012-03-27 14:56:08 UTC")
      expect(customer.created_at.class).to eq Time
    end

    it "#updated_at returns a Time instance for the date the invoice item was last updated" do
      expect(customer.updated_at).to eq Time.parse("2012-03-27 14:56:08 UTC")
      expect(customer.updated_at.class).to eq Time
    end
  end

  context "Relationships" do
    let(:invoice) { engine.invoices.find_by_id(106) }

    it "invoice#items returns all items related to the invoice" do
      expected = invoice.items
      expect(expected.length).to eq 7
      expect(expected.first.class).to eq Item
    end

    it "invoice#transactions returns all transactions related to the invoice" do
      expected = invoice.transactions
      expect(expected.length).to eq 1
      expect(expected.first.class).to eq Transaction
    end

    it "invoice#customer returns the customer related to the invoice" do
      expected = invoice.customer
      expect(expected.id).to eq 22
      expect(expected.class).to eq Customer
    end

    it "transaction#invoice returns the related invoice" do
      expected = engine.transactions.find_by_id(1452).invoice

      expect(expected.id).to eq  4746
      expect(expected.class).to eq Invoice
    end

    it "merchant#customers returns related customers" do
      expected = engine.merchants.find_by_id(12334194).customers

      expect(expected.length).to eq 13
      expect(expected.first.class).to eq Customer
    end
  end

  context "Business Intelligence" do
    it "invoice#is_paid_in_full? returns true if the invoice is paid in full" do
      expected = engine.invoices.find_by_id(1).is_paid_in_full?
      expect(expected).to eq true

      expected = engine.invoices.find_by_id(200).is_paid_in_full?
      expect(expected).to eq true

      expected = engine.invoices.find_by_id(1752).is_paid_in_full?
      expect(expected).to eq false

      expected = engine.invoices.find_by_id(1445).is_paid_in_full?
      expect(expected).to eq false
    end

    it "invoice#total returns the total dollar amount if the invoice is paid in full" do
      invoice = engine.invoices.all.first
      expected = invoice.total

      expect(invoice.is_paid_in_full?).to eq true
      expect(expected).to eq 3489.56
      expect(expected.class).to eq Float
    end
  end
end
