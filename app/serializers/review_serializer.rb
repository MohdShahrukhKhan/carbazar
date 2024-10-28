# app/serializers/review_serializer.rb
class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :user_name, :variant_name

  has_many :comments, serializer: CommentSerializer

  def user_name
    object.user.name
  end

  def variant_name
    object.variant&.variant
  end
end
