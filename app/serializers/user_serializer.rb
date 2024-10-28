class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  # Conditionally include additional attributes for dealers
  attribute :address, if: :dealer?
  attribute :brand, if: :dealer?
  attribute :mobile_number, if: :dealer?
  attribute :city, if: :dealer?

  def dealer?
    object.role == 'dealer'
  end

  # Override the serializable_hash method to exclude null attributes for customers
  def serializable_hash(*args)
    data = super(*args)
    
    # For customers, exclude attributes with nil values
    if object.role == 'customer'
      # Remove keys with nil values
      data.reject! { |key, value| value.nil? }
    end

    data
  end
end
