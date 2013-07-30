ENV["RAILS_ENV"] = "test"
DEVISE_ORM = (ENV["DEVISE_ORM"] || :active_record).to_sym

$:.unshift File.dirname(__FILE__)
puts "\n==> Devise.orm = #{DEVISE_ORM.inspect}"
# require "rails_app/config/environment"
require 'devise'
include Devise::TestHelpers
require 'active_record'
require 'active_support'
require 'test/unit'
require "orm/#{DEVISE_ORM}"
# require 'rails/test_help'
# require 'capybara/rails'
# require 'mocha/setup'
#require 'devise_sms_activable'
require 'active_support/all'

# ActionMailer::Base.delivery_method = :test
# ActionMailer::Base.perform_deliveries = true
# ActionMailer::Base.default_url_options[:host] = 'test.com'

ActiveSupport::Deprecation.silenced = true

# class ActionDispatch::IntegrationTest
#   include Capybara::DSL
# end

class ActionController::TestCase 
  include Devise::TestHelpers 
end