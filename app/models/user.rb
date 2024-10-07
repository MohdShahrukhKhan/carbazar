# app/models/user.rb
class User < ApplicationRecord
    has_secure_password  # This adds methods for setting and authenticating passwords
    has_many :wishlists
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    has_many :bookings
    has_many :notifications
    has_many :reviews
    has_many :orders

    def self.ransackable_attributes(auth_object = nil)
    super + ['name', 'email','password', 'password_confirmation']
  end


  end
  
