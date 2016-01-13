## Iteration 3 - Item Sales

require "spec_helper"

RSpec.describe "Iteration 3" do
  context "Invoice Items" do
    it "#all returns an array of all invoice item instances" do
      expected = engine.invoice_items.all
      expect(expected.count).to eq 21687
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

    it "#invoice_id returns the item id" do
      expect(invoice_item.invoice_id).to eq 522
      expect(invoice_item.invoice_id.class).to eq Fixnum
    end

    it "#unit_price returns the unit price" do
      expect(invoice_item.unit_price).to eq 847.0
      expect(invoice_item.unit_price.class).to eq BigDecimal
    end

    it "#created_at returns a Time instance for the date the invoice item was created" do
      expect(invoice_item.created_at).to eq Time.new("2012-01-01 00:00:00.000000000 -0700")
      expect(invoice_item.created_at.class).to eq Time
    end

    it "#updated_at returns a Time instance for the date the invoice item was last updated" do
      expect(invoice_item.updated_at).to eq Time.new("2012-01-01 00:00:00.000000000 -0700")
      expect(invoice_item.updated_at.class).to eq Time
    end
  end
end
