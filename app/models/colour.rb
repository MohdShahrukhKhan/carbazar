class Colour < ApplicationRecord
  validates :name, presence: true
  validates :colour_code, presence: true  # Use snake_case for attribute names

  belongs_to :feature  # Association with Feature model

  # Allow Ransack to search by feature_id
  ransack_alias :feature_id_eq, :feature_id

  def self.ransackable_attributes(auth_object = nil)
    super + ['feature_id']
  end
end
