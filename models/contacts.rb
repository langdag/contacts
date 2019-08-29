class Contacts
  include ActiveModel::Validations

  attr_reader :name, :email, :file, :message

  validates :name, presence: true, length: { in: 3..250 }
  validates :file, presence: true
  validates :message, presence: true, length: { minimum: 50 }
  validates :email, presence: true, format: { with: /A[^@s] @[^@s] z/, allow_blank: true }

  def initialize(name=nil, email=nil, file=nil, message=nil)
    @name = name
    @email = email
    @file = file
    @message = message
  end

end