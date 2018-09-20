class User < ApplicationRecord
  has_secure_password

  has_many :issues

  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email
end
