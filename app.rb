require("bundler")
Bundler.require
require 'pry'
require_relative 'models/contacts'


Recaptcha.configure do |config|
  config.site_key  = '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI'
  config.secret_key = '6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe'
end

include Recaptcha::Adapters::ControllerMethods
include Recaptcha::Adapters::ViewMethods


get '/' do
  erb :index, locals: { contacts: Contacts.new }
end

post '/submitted' do
 contacts = Contacts.new(params[:name], params[:email], params[:message], params[:file])
 if contacts.valid?
   puts "Helllo, I am working"
 else
   erb :errors_form, locals: { contacts: contacts.errors }
 end
end

