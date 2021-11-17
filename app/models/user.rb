class User < ApplicationRecord
  has_one_attached :image

  validates :first_name,:last_name,:date_of_birth,presence: true
  validates :email,presence: true,uniqueness: true
  validates :password,presence: true,confirmation: true
  validates :mobile,presence: true
  attr_accessor :password
  before_save :encrypt_password
  def authenticate(email,string)
    user=User.find_by_email(email)
    if hashed_password ==encrypt(string)
      return user
    end
  end
  private
  def encrypt_password
    self.hashed_password=encrypt(password)
  end
  def encrypt(string)
    Digest::SHA1.hexdigest(string)
  end

end
