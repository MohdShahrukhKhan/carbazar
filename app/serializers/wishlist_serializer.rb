# class WishlistSerializer < ActiveModel::Serializer
#   attributes :id, :created_at

#   #belongs_to :feature, serializer: FeatureSerializer

# attribute :variant_price do |object|
#   object.object.variant.variant
# end
# attribute :variant_name do |object|
#   object.object.variant.price
# end

# attribute :car_name do |object|
#   object.object.car.name
# end

# end

# class WishlistSerializer < ActiveModel::Serializer
#   attributes :id, :variant_name

#   def variant_name
#     object.variant&.variant || 'No variant available'
#   end

#   attribute :user_name do |object|
#   object.object.user.name
#   end
#    attribute :variant_name do |object|
#   object.object.variant.price
# end
#  attribute :discounted_price do |object|
#   object.object.variant.offers.discounted_price
# end
# end


class WishlistSerializer < ActiveModel::Serializer
  attributes :id, :variant_name, :price, :discounted_price
   # :user_name,
  def variant_name
    object.variant&.variant || 'No variant available'
  end

  # def user_name
  #   object.user&.name || 'No user name'
  # end

  def price
    object.variant&.price || 'No price available'
  end

  def discounted_price
    object.variant&.discounted_price || 'No discounted price available'
  end
end
