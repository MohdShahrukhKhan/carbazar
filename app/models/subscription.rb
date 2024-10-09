class Subscription < ApplicationRecord

  belongs_to :user
  belongs_to :plan


  # def self.ransackable_attributes(auth_object = nil)
  #   super + ['plan_id']
  # end
  
  # ransack_alias :subscription_id_eq, :subscription_id

  #  def self.ransackable_attributes(auth_object = nil)
  #   super + ['subscription_id']
  # end
  # ransack_alias :plan_id_eq, :plan_id

  #  def self.ransackable_attributes(auth_object = nil)
  #   super + ['subscription_id']
  # end

 # def self.ransackable_attributes(auth_object = nil)
 #    super + ['plan_id'] # Ensure 'plan_id' is ransackable
 #  end

 def self.ransackable_attributes(auth_object = nil)
    super + ['user_id', 'plan_id']
  end

end



