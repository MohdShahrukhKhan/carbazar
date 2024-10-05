class Feature < ApplicationRecord
 belongs_to :car
 has_many :offers,dependent: :destroy 
 # has_many :colours
 belongs_to :variant


  ransack_alias :car_id_eq, :car

  def self.ransackable_attributes(auth_object = nil)
    super + ['car_id', 'variant_id']
  end

  # def discounted_price
  #   active_offer = offers.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).first

  #   if active_offer.present?
  #     discount_amount = (price.to_f * active_offer.discount / 100)
  #     price.to_f - discount_amount
  #   else
  #     price.to_f
  #   end
  # end

  validates :city_mileage, :fuel_type, :engine_displacement,
            :no_of_cylinders, :max_power, :max_torque, :seating_capacity, :transmission_type,
            :boot_space, :fuel_tank_capacity, :body_type, presence: true

  validates :fuel_type, inclusion: { in: ['Petrol', 'Diesel', 'Electric', 'Hybrid'], message: "%{value} is not a valid fuel type" }
  validates :transmission_type, inclusion: { in: ['Manual', 'Automatic', 'CVT', 'Dual-Clutch'], message: "%{value} is not a valid transmission type" }
  validates :body_type, inclusion: { in: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible'], message: "%{value} is not a valid body type" }
  validates :engine_displacement, :no_of_cylinders, :seating_capacity, :boot_space, :fuel_tank_capacity, numericality: { greater_than: 0 }


  
end
