# app/serializers/order_item_serializer.rb
class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :variant_id, :quantity, :price

  # If you want to include the variant details in the response
  belongs_to :variant
end
