# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :car
  belongs_to :variant
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
  def self.ransackable_attributes(auth_object = nil)
    super + ['user_id', 'car_id', 'variant_id', 'rating','comment']
  end


end
