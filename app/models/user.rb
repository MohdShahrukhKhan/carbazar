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


    has_one :subscription



    def self.ransackable_attributes(auth_object = nil)
    super + ['name', 'email','password', 'password_confirmation']
  end



def subscription_active?
  current_subscription = subscription 
  return false unless current_subscription 
  current_subscription.started_at <= Time.current && current_subscription.expires_at >= Time.current
end


  end
  
