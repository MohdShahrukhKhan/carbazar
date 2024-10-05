class Car < ApplicationRecord
  belongs_to :brand
  has_many :offers
  has_many :features, dependent: :destroy
  has_many :wishlists
  has_many :bookings
  has_many :review
 # has_many :variants, dependent: :destroy
  accepts_nested_attributes_for :features, allow_destroy: true
 # accepts_nested_attributes_for :variants, allow_destroy: true
  has_many :variants, dependent: :destroy
  accepts_nested_attributes_for :variants, allow_destroy: true


  # Allow Ransack to search by brand_id
  ransack_alias :brand_id_eq, :brand_id

  def self.ransackable_attributes(auth_object = nil)
    super + ['brand_id']
  end


  validates :name, presence: true
  validates :brand_id, presence: true
  validates :body_type, presence: true, inclusion: {
    in: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible'],
    message: "%{value} is not a valid body type"
  }
  validates :car_types, presence: true, inclusion: {
    in: ['New Car', 'Upcoming Car'],
    message: "%{value} is not a valid car type"
  }
  # validates :launch_date, presence: true
  validate :launch_date_cannot_be_in_the_past

  # Custom validation method
  def launch_date_cannot_be_in_the_past
    if launch_date.present? && launch_date < Date.today
      errors.add(:launch_date, "can't be in the past")
    end
  end

  scope :by_price_range, ->(min, max) { where(price: min..max) }
  scope :by_body_type, ->(body_type) { where(body_type: body_type) }
  scope :by_fuel_type, ->(fuel_type) { where(fuel_type: fuel_type) }
  scope :new_cars, -> { where(car_type: 'New Car') }
  scope :upcoming_cars, -> { where(car_type: 'Upcoming Car') }

end
