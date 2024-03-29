ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "faker"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Fixtures replacement with factory_bot
  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end
