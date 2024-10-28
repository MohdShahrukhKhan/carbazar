class Car < ApplicationRecord
  belongs_to :brand
  belongs_to :user
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
  validate :launch_date_presence
  validate :launch_date_cannot_be_in_the_past

  # Custom validation to ensure launch_date is present for upcoming cars
  private

  def launch_date_presence
    if car_types == "Upcoming Car" && launch_date.blank?
      errors.add(:launch_date, "must be present for upcoming cars")
    elsif car_types == "New Car" && launch_date.present?
      errors.add(:launch_date, "should be skipped for new cars")
    end
  end

  # Custom validation method
  def launch_date_cannot_be_in_the_past
    if launch_date.present? && launch_date < Date.today
      errors.add(:launch_date, "can't be in the past")
    end
  end

  scope :by_body_type, ->(body_type) { where(body_type: body_type) }
  scope :new_cars, -> { where(car_types: 'New Car') }
  scope :upcoming_cars, -> { where(car_types: 'Upcoming Car') }
  scope :popular, -> { order(views_count: :desc) }
end





# class Car < ApplicationRecord
#   belongs_to :brand
#   belongs_to :user
#   has_many :variants, dependent: :destroy
#   accepts_nested_attributes_for :variants, allow_destroy: true




#  # Allow Ransack to search by brand_id
#   ransack_alias :brand_id_eq, :brand_id

#   def self.ransackable_attributes(auth_object = nil)
#     super + ['brand_id']
#   end

# validate :launch_date_presence

#   # Other model code...

#   private

#   # Custom validation to ensure launch_date is present for upcoming cars
#   def launch_date_presence
#     if car_types == "Upcoming Car" && launch_date.blank?
#       errors.add(:launch_date, "must be present for upcoming cars")
#     elsif car_types == "New Car" && launch_date.present?
#       errors.add(:launch_date, "should be skipped for new cars")
#     end
#   end



#   validates :name, presence: true
#   validates :brand_id, presence: true
#   validates :body_type, presence: true, inclusion: {
#     in: ['SUV', 'Sedan', 'Hatchback', 'Coupe', 'Convertible'],
#     message: "%{value} is not a valid body type"
#   }
#   validates :car_types, presence: true, inclusion: {
#     in: ['New Car', 'Upcoming Car'],
#     message: "%{value} is not a valid car type"
#   }
#   validate :launch_date_cannot_be_in_the_past

#   # Custom validation method
#   def launch_date_cannot_be_in_the_past
#     if launch_date.present? && launch_date < Date.today
#       errors.add(:launch_date, "can't be in the past")
#     end
#   end


#   scope :by_body_type, ->(body_type) { where(body_type: body_type) }
#   scope :new_cars, -> { where(car_type: 'New Car') }
#   scope :upcoming_cars, -> { where(car_type: 'Upcoming Car') }

  
# end
