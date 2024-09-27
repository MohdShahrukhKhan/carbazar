class Dealer < ApplicationRecord
    belongs_to :brand
  
    validates :name, presence: true, uniqueness: true
    validates :address, presence: true  # Consider if this needs uniqueness
    validates :contact_number, presence: true, uniqueness: true
  
    # Correcting the alias
    ransack_alias :brand_id_eq, :brand_id  # Change dealer_id to brand_id
  
    def self.ransackable_attributes(auth_object = nil)
      super + ['brand_id']  # Only add brand_id for filtering
    end
  end
  
