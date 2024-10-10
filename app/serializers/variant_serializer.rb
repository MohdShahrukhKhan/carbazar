class VariantSerializer < ActiveModel::Serializer
  attributes :id, :price, :colour, :quantity

 # has_many :features

 # has_many :offers

 attribute :car_name do  |object|
  object.object.car.name
 end




end
