# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

App2::Application.configure do
config.action_mailer.delivery_method =  :test
end

#config.action_mailer.delivery_method = :smtp 
  ActionMailer::Base.smtp_settings = {   
  :address => "smtp.gmail.com",   
  :port => 587,   
  :domain => "gmail.com",   
  :user_name => "fmart.test",   
  :password =>  "15324268",   
  :authentication => "plain",   
  :enable_starttls_auto => true  
}