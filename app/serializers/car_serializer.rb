class CarSerializer < ActiveModel::Serializer
  attributes :id, :name, :body_type, :car_types, :launch_date





  attribute :brand_name do |object|
      object.object.brand.name
    end
 
  
  

 



 end









