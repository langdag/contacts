require('bundler')
Bundler.require
require 'dotenv/load'
require 'pry'
require 'letter_opener'
require_relative 'models/contacts'
require_relative 'config/environment'

get '/' do
  erb :index
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
