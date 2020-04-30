ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'support/workflows.rb'
glb = Rails.root.join('test', 'support', '**', '*rb')
Dir[glb].each do |file|
  require file
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Add more helper methods to be used by all tests here...
end
