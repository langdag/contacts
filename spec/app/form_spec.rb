require File.expand_path '../../acceptance_helper.rb', __FILE__

RSpec.describe "POST request" do

  it 'with message too short' do
    visit '/'
    within('form#contacts') do 
      fill_in :message, with: "Hello!"
    end
    click_button 'Send'
    expect(page).to have_content('Message is too short (minimum is 10 characters)')
  end

  it 'with blank message' do
    visit '/'
    within('form#contacts') do 
      fill_in :message, with: ""
    end
    click_button 'Send'
    expect(page).to have_content('Message can\'t be blank')
  end

  it 'with name too short' do
    visit '/'
    within('form#contacts') do 
      fill_in :name, with: "AI"
    end
    click_button 'Send'
    expect(page).to have_content('Name is too short (minimum is 3 characters)')
  end

  it 'with name too long' do
    visit '/'
    within('form#contacts') do 
      fill_in :name, with: "Orci nulla pellentesque dignissim enim sit.
      Augue lacus viverra vitae congue eu consequat ac felis.
      Aliquet sagittis id consectetur purus ut faucibus pulvinar elementum integer.
      Vitae nunc sed velit dignissim sodales ut eu sem integer.
      Nisi scelerisque eu ultrices vitae auctor eu augue ut.
      Sit amet justo donec enim. Magna sit amet purus gravida quis.
      Non pulvinar neque laoreet suspendisse interdum consectetur libero id.
      Sociis natoque penatibus et magnis dis parturient.
      Et tortor at risus viverra adipiscing at in.
      Molestie a iaculis at erat pellentesque adipiscing commodo elit at.
      Quam lacus suspendisse faucibus interdum posuere. Sit amet porttitor eget dolor.
      Amet venenatis urna cursus eget nunc scelerisque viverra.
      Id volutpat lacus laoreet non curabitur gravida arcu ac.
      Sed risus pretium quam vulputate dignissim suspendisse."
    end
    click_button 'Send'
    expect(page).to have_content('Name is too long (maximum is 250 characters)')
  end

  it 'with blank name' do
    visit '/'
    within('form#contacts') do 
      fill_in :name, with: ""
    end
    click_button 'Send'
    expect(page).to have_content('Name can\'t be blank')
  end

  it 'with invalid email' do
    visit '/'
    within('form#contacts') do 
      fill_in :email, with: "user23412example.com"
    end
    click_button 'Send'
    expect(page).to have_content('Email is invalid')
  end

  it 'with blank email' do
    visit '/'
    within('form#contacts') do 
      fill_in :email, with: ""
    end
    click_button 'Send'
    expect(page).to have_content('Email can\'t be blank')
  end

  it "with full valid fields" do
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