require File.dirname(__FILE__) + '/spec_helper'

require 'capybara'
require 'capybara/rspec'

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
end