require "spec_helper"

RSpec.describe "Merchants" do
  context "Merchant" do
    it "#id returns the merchant id" do
      merchant_one = engine.merchant_repository.merchants.first
      expect(merchant_one.id).to eq 12334105

      merchant_two = engine.merchant_repository.merchants.last
      expect(merchant_two.id).to eq 12337412
    end

    it "#name returns the merchant name" do
      merchant_one = engine.merchant_repository.merchants.first
      expect(merchant_one.name).to eq "Shopin1901"

      merchant_two = engine.merchant_repository.merchants.last
      expect(merchant_two.name).to eq "CJsDecor"
    end
  end

  context "Merchant Repository" do
    it "#all returns an array of all merchant instances" do
      expected = engine.merchant_repository.all
      expect(expected.count).to eq 476
    end

    it "#find_by_id finds a merchant by id" do
      id = 12335971
      expected = engine.merchant_repository.find_by_id(id)

      expect(expected.id).to eq 12335971
      expect(expected.name).to eq "ivegreenleaves"
    end

    it "#find_by_id returns nil if the merchant does not exist" do
      id = 101
      expected = engine.merchant_repository.find_by_id(id)

      expect(expected).to eq nil
    end

    it "#find_by_name finds the first matching merchant by name" do
      name = "leaburrot"
      expected = engine.merchant_repository.find_by_name(name)

      expect(expected.id).to eq 12334411
      expect(expected.name).to eq name
    end

    it "#find_by_name is a case insensitive search" do
      name = "LEABURROT"
      expected = engine.merchant_repository.find_by_name(name)

      expect(expected.id).to eq 12334411

      name = "leaburrot"
      expected = engine.merchant_repository.find_by_name(name)

      expect(expected.id).to eq 12334411
    end

    it "#find_by_name returns nil if the merchant does not exist" do
      name = "Turing School of Software and Design"
      expected = engine.merchant_repository.find_by_name(name)

      expect(expected).to eq nil
    end

    it "#find_all_by_name finds all matching merchants by name" do
      name = "CJsDecor"
      expected = engine.merchant_repository.find_all_by_name(name)

      expect(expected.length).to eq 2
      expect(expected.first.name).to eq name

      expect(expected.first.id).to eq 12337411
      expect(expected.last.id).to eq 12337412
    end

    it "#find_all_by_name is a case insensitive search" do
      name = "CJSDECOR"
      expected = engine.merchant_repository.find_all_by_name(name)

      expect(expected.size).to eq 2

      name = "cjsdecor"
      expected = engine.merchant_repository.find_all_by_name(name)

      expect(expected.size).to eq 2
    end

    it "#find_all_by_name returns an empty array if there are no matches" do
      name = "Turing School of Software and Design"
      expected = engine.merchant_repository.find_all_by_name(name)

      expect(expected.size).to eq 0
    end
  end

  context "Relationships" do
    it "#items returns associated items" do
      id = 12335971
      merchant = engine.merchant_repository.find_by_id(id)
      expected = merchant.items

      expect(expected.length).to eq 1
    end
  end
end
