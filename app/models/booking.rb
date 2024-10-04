class Booking < ApplicationRecord
 enum status: { pending: 0, confirmed: 1, canceled: 2, completed: 3 }

  belongs_to :user
  belongs_to :car
  belongs_to :variant

  validates :booking_date, presence: true
  validates :status, inclusion: { in: statuses.keys }
  def self.ransackable_attributes(auth_object = nil)
    super + ['user_id', 'car_id', 'variant_id','status']
  end


end
