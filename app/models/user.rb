class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :api_key, dependent: :destroy

  after_create :create_api_key

  default_scope order(email: :asc)
  scope :admins, -> { where(admin: true) }

  def admin?
    admin == true
  end

  private

  def create_api_key
    ApiKey.create user: self
  end
end
