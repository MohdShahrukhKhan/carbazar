class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :variant


 # ransack_alias :user, :user_id
# ransack_alias :feature, :feature_id



  def self.ransackable_attributes(auth_object = nil)
    super + ['user_id', 'variant_id']
  end
end