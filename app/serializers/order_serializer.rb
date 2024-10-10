# app/serializers/order_serializer.rb
class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_price, :status
  # If you want to include associated order items in the response
  has_many :order_items

    attribute :user_name do |object|
  object.object.user.name
  end

end
