# app/serializers/review_serializer.rb
class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :comment

  attribute :user_name do |object|
  object.object.user.name
end
attribute :car_name do |object|
  object.object.car.name
end
attribute :variant_name do |object|
  object.object.variant.variant
end
end