# class CommentSerializer < ActiveModel::Serializer
#   attributes :id, :text, :user_name
#   attribute :parent_comment_id, if: -> { reply_present? }

#   def user_name
#     object.user.name
#   end

#   def created_at
#     object.created_at.strftime("%Y-%m-%d %H:%M:%S")
#   end

#   private # Keep this method private

#   # This method checks if the comment has a parent, indicating it's a reply
#   def reply_present?
#     object.parent_comment_id.present?
#   end
# end


# class CommentSerializer < ActiveModel::Serializer
#   attributes :id, :text, :user_name
#   attribute :parent_comment_id, if: :reply_present?
#   has_many :replies, serializer: ReplySerializer

#   def user_name
#     object.user.name
#   end

#   def created_at
#     object.created_at.strftime("%Y-%m-%d %H:%M:%S")
#   end

#   private

#   # This method checks if the comment has a parent, indicating it's a reply
#   def reply_present?
#     object.parent_comment_id.present?
#   end

#   class ReplySerializer < ActiveModel::Serializer
#     attributes :id, :text, :user_name, :created_at

#     def user_name
#       object.user.name
#     end

#     def created_at
#       object.created_at.strftime("%Y-%m-%d %H:%M:%S")
#     end
#   end
# end



class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :user_name
  attribute :parent_comment_id, if: -> { reply_present? }

  has_many :replies, key: :replies, if: -> { object.replies.any? }

  def user_name
    object.user.name
  end

  def created_at
    #object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def replies
    object.replies.map do |reply|
      {
        id: reply.id,
        text: reply.text,
        user_name: reply.user.name,
        #created_at: reply.created_at.strftime("%Y-%m-%d %H:%M:%S")
      }
    end
  end

  private

  def reply_present?
    object.parent_comment_id.present?
  end
end

