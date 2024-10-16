class Subscription < ApplicationRecord

  belongs_to :user
  belongs_to :plan

  validates :started_at, presence: true
  validates :expires_at, presence: true



 def self.ransackable_attributes(auth_object = nil)
    super + ['user_id', 'plan_id']
  end

end



