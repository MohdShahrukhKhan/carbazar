# # app/serializers/booking_serializer.rb
# class BookingSerializer < ActiveModel::Serializer
#   attributes :id, :status, :booking_date, :offer_name
#   belongs_to :user

#   attribute :user_name do |object|
#     object.object.user.name
#   end  

#   attribute :variant_name do |object|
#   object.object.variant.variant
# end
# attribute :variant_price do |object|
#   object.object.variant.price
# end

# attribute :car_name do |object|
#   object.object.car.name
# end

#   attribute :offer_name do |object|
#     # Accessing the first offer's name directly from the associated variant
#     offer = object.object.variant.offers.
#     offer.present? ? offer.offer_name : 'No offer available'
#   end


# end



# class BookingSerializer < ActiveModel::Serializer
#   attributes :id, :car_id, :variant_id, :status, :booking_date

#   belongs_to :user

#   attribute :user_name do |object|
#     object.user&.name || 'No user available'
#   end  

#   attribute :variant_name do |object|
#     object.variant&.variant || 'No variant available'
#   end

#   attribute :variant_price do |object|
#     object.variant&.price || 'Price not available'
#   end

#   attribute :car_name do |object|
#     object.car&.name || 'No car available'
#   end

#   attribute :offer_name do |object|
#     # Accessing the last offer's name from the associated variant, if any
#     offer = object.variant&.offers&.last
#     offer&.offer_name || 'No offer available'
#   end
# end


class BookingSerializer < ActiveModel::Serializer
  attributes :id,:variant_id, :status, :booking_date

  # belongs_to :user  # Ensure this association is present

  # attribute :user_name do |object|
  #   object.user&.name || 'No user available'
  # end  

  # attribute :variant_name do |object|
  #   object.variant&.variant || 'No variant available'
  # end

  # attribute :variant_price do |object|
  #   object.variant&.price || 'Price not available'
  # end

  # attribute :car_name do |object|
  #   object.car&.name || 'No car available'
  # end

  # attribute :offer_name do |object|
  #   offer = object.variant&.offers&.last
  #   offer&.offer_name || 'No offer available'
  # end
end
