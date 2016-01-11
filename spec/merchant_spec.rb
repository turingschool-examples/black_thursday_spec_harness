require "spec_helper"

RSpec.describe "Merchants" do
  context "Merchant" do
    it "#id returns the merchant id" do
      merchant_one = engine.merchant_repository.merchants.first
      expect(merchant_one.id).to eq 1

      merchant_two = engine.merchant_repository.merchants.last

      expect(merchant_two.id).to eq 100
    end

    it "#name returns the merchant name" do
      merchant_one = engine.merchant_repository.merchants.first

      expect(merchant_one.name).to eq "Schroeder-Jerde"

      merchant_two = engine.merchant_repository.merchants.last

      expect(merchant_two.name).to eq "Wisozk, Hoeger and Bosco"
    end
  end

  context "Merchant Repository" do
    it "#all returns an array of all merchant instances" do
      expected = engine.merchant_repository.all
      expect(expected.count).to eq 100
    end

    it "#find_by_id(id) finds a merchant by id" do
      id = 10
      expected = engine.merchant_repository.find_by_id(id)

      expect(expected.id).to eq 10
      expect(expected.name).to eq "Bechtelar, Jones and Stokes"
      expect(expected.created_at).to eq "2012-03-27 14:54:00 UTC"
      expect(expected.updated_at).to eq "2012-03-27 14:54:00 UTC"
    end

    it "#find_by_id(id) returns nil if the merchant does not exist" do
      id = 101
      expected = engine.merchant_repository.find_by_id(id)

      expect(expected).to eq nil
    end

    it "#find_by_name(name) finds the first matching merchant by name" do
      name = "Ernser, Borer and Marks"
      expected = engine.merchant_repository.find_by_name(name)

      expect(expected.id).to eq 30
      expect(expected.name).to eq "Ernser, Borer and Marks"
      expect(expected.created_at).to eq "2012-03-27 14:54:01 UTC"
      expect(expected.updated_at).to eq "2012-03-27 14:54:01 UTC"
    end

    it "#find_by_name(name) is a case insensitive search" do
      name = "ERNSER, BORER and MARKS"
      expected = engine.merchant_repository.find_by_name(name)

      expect(expected.id).to eq 30

      name = "ernser, borer and marks"
      expected = engine.merchant_repository.find_by_name(name)

      expect(expected.id).to eq 30
    end

    it "#find_by_name(name) returns nil if the merchant does not exist" do
      name = "Turing School of Software and Design"
      expected = engine.merchant_repository.find_by_name(name)

      expect(expected).to eq nil
    end

    it "#find_all_by_name(name) finds all matching merchants by name" do
      name = "Williamson Group"
      expected = engine.merchant_repository.find_all_by_name(name)

      expect(expected.length).to eq 2
      expect(expected.first.name).to eq "Williamson Group"

      expect(expected.first.id).to eq 5
      expect(expected.last.id).to eq 6
    end

    it "#find_all_by_name(name) is a case insensitive search" do
      name = "WILLIAMSON GROUP"
      expected = engine.merchant_repository.find_all_by_name(name)

      expect(expected.size).to eq 2

      name = "williamson group"
      expected = engine.merchant_repository.find_all_by_name(name)

      expect(expected.size).to eq 2
    end

    it "#find_all_by_name(name) returns an empty array if there are no matches" do
      name = "Turing School of Software and Design"
      expected = engine.merchant_repository.find_all_by_name(name)

      expect(expected.size).to eq 0
    end
  end
end
