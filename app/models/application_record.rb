class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_associations(auth_object = nil)
    ["feature"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["body_type", "brand", "created_at", "feature_id", "id", "name", "price", "updated_at", "car_types"]
  end
end
