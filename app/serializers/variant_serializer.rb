class VariantSerializer < ActiveModel::Serializer
  attributes :id, :price, :colour, :car_id

 has_many :features

 has_many :offers

end
