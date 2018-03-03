class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:login]
  attr_accessor :login

  validates :user_id,
    uniqueness: { case_sensitive: :false },
    length : { minimum: 4, maximum: 20 },
    format: { with /\A[a-z0-9]+\z, message: "ユーザIDは半角英数字です" }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions =warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["user_id = :value OR lower(email) = lower(:value)", { :value = login }]).first
    else
      where(conditions).first
    end
end
