require 'avocado'

# Extend the Cucumber World object with some convenience methods
#   request: alias for last_request
#   response: alias for last_response
World(Avocado::World)

# After hook for all running Cucumber tests, this block extends the proper
# Avocado module based on what type of object is passed to the block by Cucumber:
#   Cucumber::Ast::Scenario will extend Avocado::Scenario
#   Cucumber::Ast::OutlineTable::ExampleRow will extend Avocado::ExampleRow
# These extensions provide a common interface for interacting with the scenario properties,
# so type-checking can be ignored while storing each scenario.
After do |scenario|
  scenario.extend("Avocado::#{scenario.class.name.demodulize}".constantize)
  Avocado.store scenario, request, response
end

# When Cucumber finishes, document! will write all of the stored scenarios to the
# view files, so that they can be seen wherever Avocado is mounted. Unfortunately
# using Kernel#at_exit is the only way to do an "After All" hook in Cucumber
at_exit do
  Avocado.document!
end