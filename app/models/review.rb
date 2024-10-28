# # app/models/review.rb
# class Review < ApplicationRecord
#   belongs_to :variant
#   belongs_to :user
#   has_many :comments


#   validates :rating, presence: true, inclusion: { in: 1..5 }
#   def self.ransackable_attributes(auth_object = nil)
#     super + ['user_id','variant_id', 'rating','comment']
#   end


# end

class Review < ApplicationRecord
  belongs_to :variant
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :rating, presence: true, inclusion: { in: 1..5 }

  accepts_nested_attributes_for :comments, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    super + ['user_id', 'variant_id', 'rating', 'comment']
  end
end

