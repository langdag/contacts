require('bundler')
Bundler.require
require 'pry'
require 'letter_opener'
require_relative 'models/contacts'

Recaptcha.configure do |config|
  config.site_key = '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI'
  config.secret_key = '6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe'
end

include Recaptcha::Adapters::ControllerMethods
include Recaptcha::Adapters::ViewMethods

get '/' do
  erb :index
end

Mail.defaults do
  delivery_method LetterOpener::DeliveryMethod,
                  location: File.expand_path('../tmp/letter_opener', __dir__)
end

post '/submitted' do
  contacts = Contacts.new(params[:name], params[:email],
                          params[:file], params[:message])
  if contacts.valid? && verify_recaptcha(contacts)
    file_name = params[:file][:filename]
    tempfile = params[:file][:tempfile]

    Mail.deliver do
      from     contacts.email
      to       'example@gmail.com'
      subject  contacts.name
      body     contacts.message
      add_file filename: file_name, content: File.read(tempfile)
    end
    erb :success
  else
    erb :errors_form, locals: { contacts: contacts.errors }
  end
end
