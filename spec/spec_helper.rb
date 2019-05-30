ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'
require 'database_cleaner'


ActiveRecord::Migration.maintain_test_schema!

Capybara.app = MicroLearningApp

DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.include Capybara::DSL

c.before(:all) do
    DatabaseCleaner.clean
  end

c.after(:each) do
    DatabaseCleaner.clean
  end
end