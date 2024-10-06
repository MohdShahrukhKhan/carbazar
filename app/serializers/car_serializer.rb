class CarSerializer < ActiveModel::Serializer
  attributes :id, :name, :body_type, :car_types, :launch_date



  # def offer_name

  #   object.offers.offer_name : object.offers.offer_name ? nil
  # end

  attribute :brand_name do |object|
      object.object.brand.name
    end
  has_many :variants
  
  

  def variant_names
    object.variants.present? ? object.variants.pluck(:variant) : []
  end

  # def offer_names
  #   # Check if offers exist, and return an array of offer names or an empty array if none exist
  #   object.offers.present? ? object.offers.pluck(:offer_name) : []
  # end


 end



# class CarSerializer < ActiveModel::Serializer
#   attributes :id, :name, :brand_id, :body_type, :car_types, :launch_date

#   # Define features as an attribute
#   attribute :features do
#     object.features.map do |feature|
#       FeatureSerializer.new(feature).as_json
#     end
#   end

#   # Define offers last
#   attribute :offers do
#     object.features.includes(:offers).flat_map do |feature|
#       feature.offers.map do |offer|
#         {
#           id: offer.id,
#           offer_name: offer.offer_name,
#           discount: offer.discount,
#           start_date: offer.start_date,
#           end_date: offer.end_date,
#           discounted_price: offer.discounted_price
#         }
#       end
#     end
#   end
# end

# class CarSerializer < ActiveModel::Serializer
#   attributes :id, :name, :brand_id, :body_type, :car_types, :launch_date

#   has_many :features, serializer: FeatureSerializer

#   attribute :offers do
#     # Use a set to collect unique offers
#     unique_offers = {}

#     # Collect offers from features, ensuring uniqueness by id
#     object.features.includes(:offers).each do |feature|
#       feature.offers.each do |offer|
#         unique_offers[offer.id] = {
#           id: offer.id,
#           offer_name: offer.offer_name,
#           discount: offer.discount,
#           start_date: offer.start_date,
#           end_date: offer.end_date,
#           discounted_price: offer.discounted_price
#         }
#       end
#     end

#     # Return unique offers as an array
#     unique_offers.values
#   end
# end






