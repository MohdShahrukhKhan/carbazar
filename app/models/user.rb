


# app/models/user.rb
class User < ApplicationRecord
    has_secure_password  # This adds methods for setting and authenticating passwords
    has_many :wishlists
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
  end
  
