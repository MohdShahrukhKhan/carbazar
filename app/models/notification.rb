class Notification < ApplicationRecord
  belongs_to :user # Assuming you have a User model
  belongs_to :booking

 
  def self.ransackable_attributes(auth_object = nil)
    super + ['user_id', 'booking_id', 'message', 'read']
  end
 


end

