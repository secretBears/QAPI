class ApiKey < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true, uniqueness: true

  before_create :generate_token
  after_initialize :initialize_defaults

  private
  def generate_token
    loop do
      self.token = SecureRandom.hex.to_s
      break unless self.class.exists?(token: token)
    end
  end

  def initialize_defaults
    self.requests ||= 0
  end
end
