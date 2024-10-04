class WishlistSerializer < ActiveModel::Serializer
  attributes :id, :created_at

  #belongs_to :feature, serializer: FeatureSerializer

attribute :variant_price do |object|
  object.object.variant.variant
end
attribute :variant_name do |object|
  object.object.variant.price
end

attribute :car_name do |object|
  object.object.car.name
end

end
