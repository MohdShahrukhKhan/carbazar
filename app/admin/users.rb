# # app/admin/users.rb

# ActiveAdmin.register User do
#   # Permitted parameters for creating or updating a user
#   permit_params :name, :email, :password, :password_confirmation

#   # Displaying the users in the index view
#   index do
#     selectable_column
#     id_column
#     column :name
#     column :email
#     column :created_at
#     actions
#   end

#   # Filtering options in the sidebar
#   filter :name
#   filter :email
#   filter :created_at

#   # Form for creating and editing users
#   form do |f|
#     f.inputs do
#       f.input :name
#       f.input :email
#       f.input :password
#       f.input :password_confirmation
#     end
#     f.actions
#   end

#   # Show page for individual user
#   show do
#     attributes_table do
#       row :id
#       row :name
#       row :email
#       row :created_at
#       row :updated_at
#     end
#     active_admin_comments
#   end
# end
ActiveAdmin.register User do
  # Permitted parameters for creating or updating a user
  permit_params :name, :email, :password, :password_confirmation, :role

  # Displaying the users in the index view
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role   # Display the role
    column :created_at
    actions
  end

  # Filtering options in the sidebar
  filter :name
  filter :email
  filter :role, as: :select, collection: User.roles.keys  # Add filter for role
  filter :created_at

  # Form for creating and editing users
  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :role, as: :select, collection: User.roles.keys, include_blank: false  # Add dropdown for role
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  # Show page for individual user
  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :role   # Display the role
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
