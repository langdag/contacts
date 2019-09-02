class Contacts
  include ActiveModel::Validations

  attr_accessor :name, :email, :file, :message

  validates :name, presence: true, length: { in: 3..250 }
  validates :file, presence: true
  validates :message, presence: true, length: { minimum: 10 }
  validates :email, presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def initialize(name = nil, email = nil, file = nil, message = nil)
    @name = name
    @email = email
    @file = file
    @message = message
  end
end
