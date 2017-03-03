# For notifying students of mistakes they might make that will trip them up
die_because = lambda do |explanation|
  puts "\e[31m#{explanation}\e[0m"
  exit 1
end

# Must run with bundle exec
unless defined? Bundler
  die_because.call "Run with `bundle exec` or you'll have issues!"
end

# Must run from root
spec_harness_root = File.expand_path('..',  __dir__)
unless File.expand_path(Dir.pwd) == spec_harness_root
  die_because.call "Run the program from the root of the Spec Harness (#{spec_harness_root.inspect})"
end

# load their code
black_thursday_root = File.join(spec_harness_root, '../black_thursday/lib')
$LOAD_PATH.unshift(black_thursday_root)
begin
  require 'sales_engine'
  require 'sales_analyst'
rescue LoadError => e
  die_because.call "Expect black thursday to be in #{black_thursday_root.inspect}, when loaded it died because #{e.inspect}"
end
require 'date'

# Must override #inspect on repositories (more on this at https://github.com/rspec/rspec-core/issues/1631)
all_repositories = Object.constants.grep(/Repository$/).map { |name| Object.const_get name }.select { |r| r.is_a?(Class) }
bad_repositories = all_repositories.select { |repo| repo.instance_method(:inspect).owner == Kernel }
if bad_repositories.any?
  die_because.call <<-MESSAGE.gsub(/^ {4}/, '')
  \e[33mTHESE REPOSITORIES HAVE ISSUES: #{bad_repositories.inspect}\e[31m

     You need to override inspect on your repositories.
     If you don't, the default inspect will try try to create a string so large that ruby will stop dead.
    This is generally true of anything that might try to print out all the rows and associated rows.

    If your test suite suddenly stops for over 2 minutes (these tests are integration, they are slow)
    then probably something is raising an exception, which inspects the object and triggers this issue.

    e.g.
    class SomeRepository
      def inspect
        "#<\#{self.class} \#{@merchants.size} rows>"
      end
    end
  MESSAGE
end


module BlackThursdaySpecHelpers
  class << self
    attr_accessor :engine
  end

  def engine
    BlackThursdaySpecHelpers.engine
  end
end

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.before(:suite) do
    BlackThursdaySpecHelpers.engine = SalesEngine.from_csv({
      items: File.join(spec_harness_root, 'csvs', 'items.csv'),
      merchants: File.join(spec_harness_root, 'csvs', 'merchants.csv'),
      customers: File.join(spec_harness_root, 'csvs', 'customers.csv'),
      invoices: File.join(spec_harness_root, 'csvs', 'invoices.csv'),
      invoice_items: File.join(spec_harness_root, 'csvs', 'invoice_items.csv'),
      transactions: File.join(spec_harness_root, 'csvs', 'transactions.csv'),
    })
  end
  File.join spec_harness_root, 'csvs'
  config.include BlackThursdaySpecHelpers
end
