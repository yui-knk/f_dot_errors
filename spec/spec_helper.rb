$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rails'
require 'f_dot_errors'
require 'fake_app/fake_app'
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
