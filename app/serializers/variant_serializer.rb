class VariantSerializer < ActiveModel::Serializer
  attributes :id, :price, :colour, :car_id, :quantity

 has_many :features

 has_many :offers

end
