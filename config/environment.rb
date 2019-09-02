configure :development do
  Recaptcha.configure do |config|
    config.site_key = '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI'
    config.secret_key = '6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe'
  end

  include Recaptcha::Adapters::ControllerMethods
  include Recaptcha::Adapters::ViewMethods

  Mail.defaults do
  delivery_method LetterOpener::DeliveryMethod,
                  location: File.expand_path('../tmp/letter_opener', __dir__)
  end
end

configure :production do
  Recaptcha.configure do |config|
    config.site_key = ENV['RECAPTCHA_ACCESS_KEY_ID']
    config.secret_key = ENV['RECAPTCHA_SECRET_KEY']
  end

  include Recaptcha::Adapters::ControllerMethods
  include Recaptcha::Adapters::ViewMethods

  Mail.defaults do
    delivery_method :smtp, options
  end

  options = { :address          => "smtp.sendgrid.net",
          :port                 => 25,
          :domain               => ENV["DOMAIN"],
          :user_name            => ENV["EMAIL_ADDRESS"],
          :password             => ENV["EMAIL_PASSWORD"],
          :user_name            => 'apikey',
          :authentication       => 'plain',
          :enable_starttls_auto => true  }
end