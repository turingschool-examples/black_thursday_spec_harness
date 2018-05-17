## Iteration 3 - Item Sales

require "spec_helper"

RSpec.describe "Iteration 3" do
  context "Invoice Item Repository" do
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

    it "#create creates a new invoice item instance" do
      attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
      engine.invoice_items.create(attributes)
      expected = engine.invoice_items.find_by_id(21831)
      expect(expected.item_id).to eq 7
    end

    it "#update updates an invoice item" do
      original_time = engine.invoice_items.find_by_id(21831).updated_at
      attributes = {
        quantity: 13
      }
      engine.invoice_items.update(21831, attributes)
      expected = engine.invoice_items.find_by_id(21831)
      expect(expected.quantity).to eq 13
      expect(expected.item_id).to eq 7
      expect(expected.updated_at).to be > original_time
    end

    it "#update cannot update id, item_id, invoice_id, or created_at" do
      attributes = {
        id: 22000,
        item_id: 32,
        invoice_id: 53,
        created_at: Time.now
      }
      engine.invoice_items.update(21831, attributes)
      expected = engine.invoice_items.find_by_id(22000)
      expect(expected).to eq nil
      expected = engine.invoice_items.find_by_id(21831)
      expect(expected.item_id).not_to eq attributes[:item_id]
      expect(expected.invoice_id).not_to eq attributes[:invoice_id]
      expect(expected.created_at).not_to eq attributes[:created_at]
    end

    it "#update on unknown invoice item does nothing" do
      engine.invoice_items.update(22000, {})
    end

    it "#delete deletes the specified invoice" do
      engine.invoice_items.delete(21831)
      expected = engine.invoice_items.find_by_id(21831)
      expect(expected).to eq nil
    end

    it "#delete on unknown invoice does nothing" do
      engine.invoice_items.delete(22000)
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
      expect(invoice_item.unit_price).to eq 847.87
      expect(invoice_item.unit_price.class).to eq BigDecimal
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

  context "Transaction Repository" do
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
      credit_card_number = "4848466917766329"
      expected = engine.transactions.find_all_by_credit_card_number(credit_card_number)

      expect(expected.length).to eq 1
      expect(expected.first.class).to eq Transaction
      expect(expected.first.credit_card_number).to eq credit_card_number

      credit_card_number = "4848466917766328"
      expected = engine.transactions.find_all_by_credit_card_number(credit_card_number)

      expect(expected.empty?).to eq true
    end

    it "#find_all_by_result returns all transactions matching given result" do
      result = :success
      expected = engine.transactions.find_all_by_result(result)

      expect(expected.length).to eq 4158
      expect(expected.first.class).to eq Transaction
      expect(expected.first.result).to eq result

      result = :failed
      expected = engine.transactions.find_all_by_result(result)

      expect(expected.length).to eq 827
      expect(expected.first.class).to eq Transaction
      expect(expected.first.result).to eq result
    end

    it "#create creates a new transaction instance" do
      attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
      engine.transactions.create(attributes)
      expected = engine.transactions.find_by_id(4986)
      expect(expected.invoice_id).to eq 8
    end

    it "#update updates a transaction" do
      original_time = engine.transactions.find_by_id(4986).updated_at
      attributes = {
        result: :failed
      }
      engine.transactions.update(4986, attributes)
      expected = engine.transactions.find_by_id(4986)
      expect(expected.result).to eq :failed
      expect(expected.credit_card_expiration_date).to eq "0220"
      expect(expected.updated_at).to be > original_time
    end

    it "#update cannot update id, invoice_id, or created_at" do
      attributes = {
        id: 5000,
        invoice_id: 2,
        created_at: Time.now
      }
      engine.transactions.update(4986, attributes)
      expected = engine.transactions.find_by_id(5000)
      expect(expected).to eq nil
      expected = engine.transactions.find_by_id(4986)
      expect(expected.invoice_id).not_to eq attributes[:invoice_id]
      expect(expected.created_at).not_to eq attributes[:created_at]
    end

    it "#update on unknown transaction does nothing" do
      engine.transactions.update(5000, {})
    end

    it "#delete deletes the specified transaction" do
      engine.transactions.delete(4986)
      expected = engine.transactions.find_by_id(4986)
      expect(expected).to eq nil
    end

    it "#delete on unknown transaction does nothing" do
      engine.transactions.delete(5000)
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
      expect(transaction.credit_card_number).to eq "4068631943231473"
      expect(transaction.credit_card_number.class).to eq String
    end

    it "#credit_card_expiration_date returns the credit card expiration" do
      expect(transaction.credit_card_expiration_date).to eq "0217"
      expect(transaction.credit_card_expiration_date.class).to eq String
    end

    it "#result returns the result" do
      expect(transaction.result).to eq :success
      expect(transaction.result.class).to eq Symbol
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

    it "#create creates a new customer instance" do
      attributes = {
        :first_name => "Joan",
        :last_name => "Clarke",
        :created_at => Time.now,
        :updated_at => Time.now
      }
      engine.customers.create(attributes)
      expected = engine.customers.find_by_id(1001)
      expect(expected.first_name).to eq "Joan"
    end

    it "#update updates a customer" do
      original_time = engine.customers.find_by_id(1001).updated_at
      attributes = {
        last_name: "Smith"
      }
      engine.customers.update(1001, attributes)
      expected = engine.customers.find_by_id(1001)
      expect(expected.last_name).to eq "Smith"
      expect(expected.first_name).to eq "Joan"
      expect(expected.updated_at).to be > original_time
    end

    it "#update cannot update id or created_at" do
      attributes = {
        id: 2000,
        created_at: Time.now
      }
      engine.customers.update(1001, attributes)
      expected = engine.customers.find_by_id(2000)
      expect(expected).to eq nil
      expected = engine.customers.find_by_id(1001)
      expect(expected.created_at).not_to eq attributes[:created_at]
    end

    it "#update on unknown customer does nothing" do
      engine.customers.update(2000, {})
    end

    it "#delete deletes the specified customer" do
      engine.customers.delete(1001)
      expected = engine.customers.find_by_id(1001)
      expect(expected).to eq nil
    end

    it "#delete on unknown customer does nothing" do
      engine.customers.delete(2000)
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

  context "Business Intelligence" do
    let(:sales_analyst) { engine.analyst }

    it "SalesAnalyst#is_paid_in_full? returns true if the invoice is paid in full" do
      expected = sales_analyst.invoice_paid_in_full?(1)
      expect(expected).to eq true

      expected = sales_analyst.invoice_paid_in_full?(200)
      expect(expected).to eq true

      expected = sales_analyst.invoice_paid_in_full?(203)
      expect(expected).to eq false

      expected = sales_analyst.invoice_paid_in_full?(204)
      expect(expected).to eq false
    end

    it "SalesAnalyst#total returns the total dollar amount if the invoice is paid in full" do
      expected = sales_analyst.invoice_total(1)

      expect(expected).to eq 21067.77
      expect(expected.class).to eq BigDecimal
    end
  end
end
