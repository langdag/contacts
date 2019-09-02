require File.expand_path '../spec_helper.rb', __dir__

RSpec.describe 'sending an email' do
  include Mail::Matchers

  before(:each) do
    Mail::TestMailer.deliveries.clear

    Mail.deliver do
      to 'client@me.com'
      from 'langdag@de.com'
      subject 'testing'
      body 'hello'
    end
  end

  it { is_expected.to have_sent_email }

  it { is_expected.to have_sent_email.from('langdag@de.com') }

  it { is_expected.to have_sent_email.to('client@me.com') }

  it { is_expected.to have_sent_email.with_subject('testing') }

  it { is_expected.to have_sent_email.with_body('hello') }
end
