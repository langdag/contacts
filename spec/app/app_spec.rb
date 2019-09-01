require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.describe "ContactsApp" do

  it "should render contacts page" do
    get '/', title: 'Contacts Form'
    expect(last_response.status).to eq 200
  end
end