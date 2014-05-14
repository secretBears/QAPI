class ApiKey < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true, uniqueness: true

  before_create :generate_token
  before_create :remove_duplicates

  private
  def generate_token
    loop do
      self.token = SecureRandom.hex.to_s
      break unless self.class.exists?(token: token)
    end
  end
end
