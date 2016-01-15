#!/usr/bin/env rake
require "csv"
require "pry"

begin
  require 'rspec/core/rake_task'
  desc "Associate invoices with invoice items"
  task :connect_invoices_with_invoice_items do
    ids = [4844,4845,4846,4847,4848,4849,4850,4851,4851,4852,4853,4854,4855,4856,
          4857,4858,4859,4860,4861,4862,4863,4864,4865,4866,4867,4868,4869,4870,
          4871,4872,4873,4874,4875,4876,4877,4878,4879,4880,4881,4882,4883,4884,
          4885,4886,4887,4888,4889,4890,4891,4892,4893,4894,4895,4896,4897,4898,
          4899,4900,4901,4902,4903,4904,4905,4906,4907,4908,4909,4910,4911,4912,
          4913,4914,4915,4916,4917,4918,4919,4920,4921,4922,4923,4924,4925,4926,
          4927,4928,4929,4930,4931,4932,4933,4934,4935,4936,4937,4938,4939,4940,
          4941,4942,4943,4944,4945,4946,4947,4948,4949,4950,4951,4952,4953,4954,
          4955,4956,4957,4958,4959,4960,4961,4962,4963,4964,4965,4966,4967,4968,
          4969,4970,4971,4972,4973,4974,4975,4976,4977,4978,4979,4980,4981,4982,
          4983,4984,4985]

    start_id = 21687

    new_rows = ids.map do |id|
      start_id += 1
  created_at = rand(Date.civil(2000, 1, 1)..Date.civil(2016, 01, 13))
      updated_at = rand(created_at..Date.civil(2016, 02, 28))

      ["#{start_id}","263519844","#{id}","#{rand(1..10)}","13635","#{created_at}","#{updated_at}"]
    end

    CSV.open("./csvs/invoice_items.csv", "ab") do |csv|
      new_rows.each { |row| csv << row }
    end
  end

  desc "Update merchants.csv to be created on random dates."
  task :update_merchants do
    csv_data = File.read "./csvs/merchants.csv"
    parsed_data = CSV.parse csv_data, headers: true, header_converters: :symbol

    parsed_data.each do |row|
      created_at = rand(Date.civil(2000, 1, 1)..Date.civil(2016, 01, 13))
      row[:created_at] = created_at

      updated_at = rand(created_at..Date.civil(2016, 02, 28))
      row[:updated_at] = updated_at
    end

    new_file = File.open "./csvs/new_merchants.csv", "w"
    new_file.write parsed_data
  end

  desc "Update Transactions.csv to random invoices"
  task :update_transactions do
    csv_data = File.read "./csvs/transactions.csv"
    parsed_data = CSV.parse csv_data, headers: true, header_converters: :symbol

    parsed_data.each do |row|
      row[:invoice_id] = rand(1..4985)
    end

    new_file = File.open "./csvs/new_transactions.csv", "w"
    new_file.write parsed_data
  end

  desc "Update Invoices.csv to random dates."
  task :update_invoices do
    csv_data = File.read "./csvs/invoices.csv"
    parsed_data = CSV.parse csv_data, headers: true, header_converters: :symbol

    parsed_data.each do |row|
      created_at = rand(Date.civil(2000, 1, 1)..Date.civil(2016, 01, 13))
      row[:created_at] = created_at

      updated_at = rand(created_at..Date.civil(2016, 02, 28))
      row[:updated_at] = updated_at
    end

    new_file = File.open "./csvs/new_invoices.csv", "w"
    new_file.write parsed_data
  end

  desc "Run each test file in the black thursday solution independently."
  namespace :test do
    task :independently do
      working_directory = Dir.pwd
      begin
        Dir.chdir('../black_thursday')
        files = Dir.glob('test/**/*_test.rb')
        files.each do |file|
          system("ruby #{file}")
        end
      ensure
        Dir.chdir(working_directory)
      end
    end
  end

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = "--tag ~merchant --tag ~customer --tag ~invoice"
  end

  task :default do
    Rake::Task["spec"].invoke

    extensions = BlackThursday::EXTENSIONS.sort rescue []

    if extensions == %w(customer invoice merchant)
      Rake::Task["spec:extensions"].invoke
    else
      extensions.each {|ext| Rake::Task["spec:extensions:#{ext}"].invoke }
    end
  end

  RSpec::Core::RakeTask.new("spec:extensions") do |t|
    t.rspec_opts = "--tag merchant --tag customer --tag invoice"
  end

  RSpec::Core::RakeTask.new("spec:extensions:merchant") do |t|
    t.rspec_opts = "--tag merchant"
  end
  RSpec::Core::RakeTask.new("spec:extensions:invoice") do |t|
    t.rspec_opts = "--tag invoice"
  end
  RSpec::Core::RakeTask.new("spec:extensions:customer") do |t|
    t.rspec_opts = "--tag customer"
  end

rescue
end
