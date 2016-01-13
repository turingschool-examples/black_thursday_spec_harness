#!/usr/bin/env rake
require "csv"
require "pry"

begin
  require 'rspec/core/rake_task'

  desc "Update Invoices.csv to random dates."
  task :update_invoices do
    csv_data = File.read "./csvs/invoices.csv"
    parsed_data = CSV.parse csv_data, headers: true, header_converters: :symbol

    parsed_data.each do |row|
      random_date = rand(Date.civil(2000, 1, 1)..Date.civil(2016, 01, 13))
      row[:created_at] = random_date
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
