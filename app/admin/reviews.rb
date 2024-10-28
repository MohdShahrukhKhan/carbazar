# ActiveAdmin.register Review do
#   permit_params :rating, :user_id, :variant_id, comments_attributes: [:id, :text, :_destroy]

#   index do
#     selectable_column
#     id_column
#     column :rating
#     column :user
#     column :variant
#     column :created_at
#     column :updated_at

#     # Display the count of comments for each review
#     column "Comments Count" do |review|
#       review.comments.count
#     end

#     actions
#   end

#   form do |f|
#     f.inputs 'Review Details' do
#       f.input :user, input_html: { disabled: true } # Disable user selection to ensure it matches the current user
#       f.input :variant
#       f.input :rating, as: :select, collection: 1..5
#     end

#     # Nested form for comments
#     f.has_many :comments, allow_destroy: true, new_record: true do |c|
#       c.input :text
#     end

#     f.actions
#   end

#   controller do
#     # Automatically set the user of any new comments to the owner of the review
#     def create
#       params[:review][:comments_attributes]&.each do |_key, comment_attrs|
#         comment_attrs[:user_id] = current_user.id if current_user.present?
#       end
#       super
#     end

#     def update
#       params[:review][:comments_attributes]&.each do |_key, comment_attrs|
#         comment_attrs[:user_id] = current_user.id if current_user.present?
#       end
#       super
#     end

#     # Ensure only the review owner can add comments
#     def update
#       review = Review.find(params[:id])
#       if review.user != current_user
#         flash[:error] = "You can only add comments to your own reviews."
#         redirect_back(fallback_location: admin_reviews_path) and return
#       end

#       params[:review][:comments_attributes]&.each do |_key, comment_attrs|
#         comment_attrs[:user_id] = current_user.id if current_user.present?
#       end
#       super
#     end
#   end

#   show do
#     attributes_table do
#       row :id
#       row :rating
#       row :user
#       row :variant
#       row :created_at
#       row :updated_at
#     end

#     panel "Comments" do
#       table_for review.comments do
#         column :id
#         column :text
#         column :user
#         column :created_at
#         column "Actions" do |comment|
#           if comment.user == current_user
#             span "You cannot reply to your own comment"
#           else
#             link_to "Reply", reply_admin_review_comment_path(review, comment) 
#           end
#         end
#       end
#     end
#   end

#   filter :rating
#   filter :user
#   filter :variant
#   filter :created_at
# end


# # ActiveAdmin.register Review do
# #   permit_params :rating, :user_id, :variant_id, comments_attributes: [:id, :text, :user_id, :_destroy]

# #   index do
# #     selectable_column
# ActiveAdmin.register Review do
#   permit_params :rating, :user_id, :variant_id, comments_attributes: [:id, :text, :user_id, :_destroy]

#   index do
#     selectable_column
#     id_column
#     column :rating
#     column :user
#     column :variant
#     column :created_at
#     column :updated_at

#     # Display the count of comments for each review
#     column "Comments Count" do |review|
#       review.comments.count
#     end

#     actions
#   end

#   form do |f|
#     f.inputs 'Review Details' do
#       f.input :user # Allow selection of a user instead of using current_user
#       f.input :variant
#       f.input :rating, as: :select, collection: 1..5
#     end

#     # Nested form for comments
#     f.has_many :comments, allow_destroy: true, new_record: true do |c|
#       c.input :user, as: :select, collection: User.all # Explicitly select a user for the comment
#       c.input :text
#     end

#     f.actions
#   end

#   controller do
#     # Ensure only the review owner can add comments
#     def update
#       review = Review.find(params[:id])
#       if review.user_id.to_s != params[:review][:user_id]
#         flash[:error] = "You can only add comments to your own reviews."
#         redirect_back(fallback_location: admin_reviews_path) and return
#       end

#       # Preserve the user assignment for nested comments
#       params[:review][:comments_attributes]&.each do |_key, comment_attrs|
#         comment_attrs[:user_id] = review.user_id
#       end
#       super
#     end
#   end

#   show do
#     attributes_table do
#       row :id
#       row :rating
#       row :user
#       row :variant
#       row :created_at
#       row :updated_at
#     end




ActiveAdmin.register Review do
  permit_params :rating, :user_id, :variant_id, comments_attributes: [:id, :text, :_destroy]

  index do
    selectable_column
    id_column
    column :rating
    column :user
    column :variant
    column :created_at
    column :updated_at

    # Display the count of comments for each review
    column "Comments Count" do |review|
      review.comments.count
    end

    actions
  end

  form do |f|
    f.inputs 'Review Details' do
      f.input :user # Allow selection of a user for the review
      f.input :variant
      f.input :rating, as: :select, collection: 1..5
    end

    # Nested form for comments, without selecting user
    f.has_many :comments, allow_destroy: true, new_record: true do |c|
      c.input :text
    end

    f.actions
  end

  controller do
    # Automatically set the comment's user to the review's user
    def create
      review = Review.new(permitted_params[:review])
      review.comments.each do |comment|
        comment.user_id = review.user_id # Ensure the user matches the review creator
      end

      if review.save
        redirect_to admin_review_path(review), notice: "Review created successfully."
      else
        flash[:error] = review.errors.full_messages.join(", ")
        render :new
      end
    end

    def update
      review = Review.find(params[:id])
      
      # Ensure only the review owner can add or edit comments
      if review.user_id.to_s != params[:review][:user_id]
        flash[:error] = "You can only add comments to your own reviews."
        redirect_back(fallback_location: admin_reviews_path) and return
      end

      # Set user for new comments to the review's user
      params[:review][:comments_attributes]&.each do |_key, comment_attrs|
        comment_attrs[:user_id] = review.user_id
      end
      
      super
    end
  end

  show do
    attributes_table do
      row :id
      row :rating
      row :user
      row :variant
      row :created_at
      row :updated_at
    end

    panel "Comments" do
      table_for review.comments do
        column :id
        column :text
        column :user
        column :created_at
      end
    end
  end

  filter :rating
  filter :user
  filter :variant
  filter :created_at
end


#     panel "Comments" do
#       table_for review.comments do
#         column :id
#         column :text
#         column :user
#         column :created_at
#       end
#     end
#   end

#   filter :rating
#   filter :user
#   filter :variant
#   filter :created_at
# end
