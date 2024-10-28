# app/serializers/order_serializer.rb
class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_price, :status, :user_name

  # Include associated order items in the response
  has_many :order_items, serializer: OrderItemSerializer

  # Fetch the user's name
  def user_name
    object.user.name
  end

  # Nested serializer for OrderItem
  class OrderItemSerializer < ActiveModel::Serializer
    attributes :variant_id, :quantity, :price, :variant_details

    # Include variant and associated car details
    def variant_details
      variant = object.variant
      {
        id: variant.id,
        name: variant.name, # Assuming the Variant model has a name attribute
        car: {
          id: variant.car.id,
          name: variant.car.name # Assuming the Car model has a name attribute
        }
      }
    end
  end
end
