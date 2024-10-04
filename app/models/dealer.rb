class Dealer < ApplicationRecord
  belongs_to :brand  # Assuming dealers are associated with a brand

  validates :name, :address, :contact_number, :brand_id, presence: true

  # Allow Ransack to search by attributes
  def self.ransackable_attributes(auth_object = nil)
    super + ['brand_id', 'address', 'name', 'contact_number','city']
  end
end

# ransack_alias :brand_id_eq, :brand_id

#   def self.ransackable_attributes(auth_object = nil)
#     super + ['brand_id']
#   end