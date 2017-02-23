# BlackThursdaySpecHarness

This is the evaluation test harness for BlackThursday.

For this to run, all the `require` statements in your BlackThursday project must be `require_relative`.

## Installing Locally

Git clone this project into a directory that lives at the same level as your `black_thursday` project directory. It should be arranged like:

    <my_code_directory>
    |
    |\
    | \black_thursday/
    |
    |\
    | \black_thursday_spec_harness/
    |

Change directories into the `black_thursday_spec_harness/` directory and then execute:

    $ bundle

This will load in your `BlackThursday` implementation from your local file system. The spec harness provides the CSV files at `./data` relative to the current directory from the perspective of the spec run.

### Usage

To test your implementation against the evaluation specs, run:

    $ bundle exec rake spec

    $ bundle exec rspec spec/iteration_0_spec.rb
                            ^^^^^^^^
                              path

using rspec will help when needing to narrow down tests from the spec harness.  You can change the path after you run the spec harness, with something like this ./spec/iteration_0_spec.rb:123 in place of the path, will help you single out the tests from the collection that is ran.
