# class Offer < ApplicationRecord
#   belongs_to :feature   
#     # Additional validations, if needed
#     validates :offer_name, presence: true
#     validates :discount, presence, numericality:{greater_than: 0, less_than_or_equal_to:0}
#     validates :start_date, presence: true
#     validates :end_date, presence: true
#   end

class Offer < ApplicationRecord
  belongs_to :feature

  validates :offer_name, presence: true
  validates :discount, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :start_date, presence: true
  validates :end_date, presence: true
end
