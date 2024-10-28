class CommentsController < ApplicationController
  before_action :set_review, only: [:create, :index]
  before_action :set_parent_comment, only: [:reply, :replies] # Add :replies here
  before_action :authorize_customer, only: [:create, :reply]

  # Fetch comments for a review
  def index
    comments = @review.comments.where(parent_comment_id: nil).includes(:replies)
    render json: comments, each_serializer: CommentSerializer
  end

  # Create a new comment
  def create
    if @review.user != current_user
      render json: { error: "You can only comment on your own review" }, status: :forbidden and return
    end

    comment = @review.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  # Fetch replies for a specific comment
  def replies
    replies = @parent_comment.replies.includes(:user) # Adjust as necessary to include associated user data
    render json: replies, each_serializer: CommentSerializer
  end

  # Reply to a comment
  # def reply
  #   # User cannot reply to their own comment
  #   if @parent_comment.user == current_user
  #     render json: { error: "You cannot reply to your own comment" }, status: :forbidden and return
  #   end

  #   reply = @parent_comment.replies.new(comment_params)
  #   reply.user = current_user
  #   reply.review = @parent_comment.review

  #   if reply.save
  #     render json: reply, status: :created
  #   else
  #     render json: reply.errors, status: :unprocessable_entity
  #   end
  # end

def reply
  # Check if the parent comment is a direct comment from the review owner
  if @parent_comment.parent_comment_id.nil? && @parent_comment.user == current_user
    render json: { error: "You cannot reply to your own initial comment" }, status: :forbidden and return
  end

  # Check if it's a reply to a reply, where User A is replying to User B's reply
  if @parent_comment.user != current_user || @parent_comment.parent_comment_id.present?
    reply = @parent_comment.replies.new(comment_params)
    reply.user = current_user
    reply.review = @parent_comment.review

    if reply.save
      render json: reply, status: :created
    else
      render json: reply.errors, status: :unprocessable_entity
    end
  else
    render json: { error: "You cannot reply to your own comment" }, status: :forbidden
  end
end

  

  private

  def set_review
    @review = Review.find(params[:review_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Review not found" }, status: :not_found
  end

  def set_parent_comment
    @parent_comment = Comment.find(params[:id]) # Use params[:id] to find the comment
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Comment not found" }, status: :not_found
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def authorize_customer
    unless current_user&.role == 'customer'
      render json: { error: "You are not authorized to perform this action" }, status: :forbidden
    end
  end
end
  




# class CommentsController < ApplicationController
#   before_action :set_review, only: [:create, :index]
#   before_action :set_parent_comment, only: [:reply]
#   before_action :authorize_customer, only: [:create, :reply]


#   def index
#     comments = @review.comments.where(parent_comment_id: nil).includes(:replies)
#     render json: comments, each_serializer: CommentSerializer
#   end

#   def create
#     # User A can comment on their own review
#     if @review.user != current_user
#       render json: { error: "You can only comment on your own review" }, status: :forbidden and return
#     end

#     comment = @review.comments.new(comment_params)
#     comment.user = current_user

#     if comment.save
#       render json: comment, status: :created
#     else
#       render json: comment.errors, status: :unprocessable_entity
#     end
#   end

#    def replies
#     replies = @parent_comment.replies
#     render json: replies, each_serializer: CommentSerializer
#   end


#   def reply
#     # User A cannot reply to their own comment
#     if @parent_comment.user == current_user
#       render json: { error: "You cannot reply to your own comment" }, status: :forbidden and return
#     end

#     # Allow User A to reply to User B's reply or any other comment
#     reply = @parent_comment.replies.new(comment_params)
#     reply.user = current_user
#     reply.review = @parent_comment.review

#     if reply.save
#       render json: reply, status: :created
#     else
#       render json: reply.errors, status: :unprocessable_entity
#     end
#   end

#   private

#   def set_review
#     @review = Review.find(params[:review_id])
#   rescue ActiveRecord::RecordNotFound
#     render json: { error: "Review not found" }, status: :not_found
#   end

#   def set_parent_comment
#     @parent_comment = Comment.find(params[:parent_comment_id])
#   rescue ActiveRecord::RecordNotFound
#     render json: { error: "Comment not found" }, status: :not_found
#   end

#   def comment_params
#     params.require(:comment).permit(:text)
#   end

#   def authorize_customer
#     unless current_user&.role == 'customer'
#       render json: { error: "You are not authorized to perform this action" }, status: :forbidden
#     end
#   end
# end
