require File.join(File.dirname(__FILE__), '..', 'task.rb')
require File.join(File.dirname(__FILE__), '..', 'server.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'

set :environment, :test

RSpec.configure do |config|
    config.before(:each) { DataMapper.auto_migrate! }
end
