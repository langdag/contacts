require File.expand_path '../../acceptance_helper.rb', __FILE__

RSpec.describe "POST request" do

  it "user fills in the form and submits it" do
    visit '/'
    within('form#contacts') do 
      fill_in :name, with: "John"
      fill_in :email, with: "user@example.com"
      fill_in :message, with: "Hi! Guess I have some great news for you. Messasge me ASAP"
      attach_file('file', 'public/img/images.jpeg')
    end
    click_button 'Send'
  end

end