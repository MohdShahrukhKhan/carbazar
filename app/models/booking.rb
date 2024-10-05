class Booking < ApplicationRecord
 enum status: { pending: 0, confirmed: 1, canceled: 2, completed: 3 }

  belongs_to :user
  belongs_to :car
  belongs_to :variant
  has_many :notifications

  validates :booking_date, presence: true
  validates :status, inclusion: { in: statuses.keys }
  def self.ransackable_attributes(auth_object = nil)
    super + ['user_id', 'car_id', 'variant_id','status']
  end

 after_update :create_status_change_notification, if: :saved_change_to_status?

private

  def create_status_change_notification
    notifications.create(
      message: "Booking status changed to #{status}",
      booking_id: id,
      user_id: user_id # Assuming you have a user_id to associate the notification
    )
  end

end
