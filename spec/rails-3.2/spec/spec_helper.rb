# encoding: utf-8

$: << File.join(File.dirname(__FILE__), "/../../lib" )

ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] = 'app_root'

FileUtils.rm(Dir.glob("#{ENV['RAILS_ROOT']}/db/*.db"), :force => true)

# Load the Rails environment and testing framework
require "#{File.dirname(__FILE__)}/../app_root/config/environment"
require 'rspec/rails'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

# Run the migrations
print "\033[30m" # dark gray text
ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")
print "\033[0m"

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.use_instantiated_fixtures  = false
  config.before(:each) do
    DatabaseCleaner.clean
  end
end
