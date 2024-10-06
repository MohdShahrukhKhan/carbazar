# ActiveAdmin.register Booking do
#   # Permit the parameters that can be set via the form
#   permit_params :user_id, :car_id, :variant_id, :status, :booking_date

#   # Filters for searching in the admin panel
#   filter :user
#   filter :car
#   filter :variant
#   filter :status, as: :select, collection: -> { Booking.statuses }
#   filter :booking_date


#   controller do
#   def create
#     super do |success, failure|
#       if success
#         variant = Variant.find(resource.variant_id)
#         if variant.quantity <= 0
#           flash[:alert] = "Cannot create booking: Variant out of stock."
#           redirect_to admin_bookings_path and return
#         end
#       end
#     end
#   end
# end


#   # Customize the index page table
#   index do
#     selectable_column
#     id_column
#     column :user
#     column :car
#     column :variant
#     column :status
#     column :booking_date
#     column :created_at
#     actions
#   end





#   # Customize the form for creating/editing a booking
#   form do |f|
#     f.inputs 'Booking Details' do
#       f.input :user
#       f.input :car
#       f.input :variant
#       f.input :status, as: :select, collection: Booking.statuses.keys
#       f.input :booking_date, as: :datetime_picker
#     end
#     f.actions
#   end

#   # Show page customization
#   show do
#     attributes_table do
#       row :id
#       row :user
#       row :car
#       row :variant
#       row :status
#       row :booking_date
#       row :created_at
#       row :updated_at
#     end
#     active_admin_comments
#   end

#  controller do
#     def update
#       super do |success, failure|
#         if success && resource.status_changed? && resource.status == 'confirmed'
#           variant = Variant.find(resource.variant_id)
#           if variant.quantity > 0
#             variant.update(quantity: variant.quantity - 1)
#           else
#             flash[:alert] = "Cannot confirm booking: Variant out of stock."
#             redirect_to admin_booking_path(resource) and return
#           end
#         end
#       end
#     end
#   end

  
# end




ActiveAdmin.register Booking do
  # Permit the parameters that can be set via the form
  permit_params :user_id, :variant_id, :status, :booking_date

  # Filters for searching in the admin panel
  filter :user
  filter :variant
  filter :status, as: :select, collection: -> { Booking.statuses }
  filter :booking_date

  # Customize the index page table
  index do
    selectable_column
    id_column
    column :user
    column :variant
    column :status
    column :booking_date
    column :created_at
    actions
  end

  # Customize the form for creating/editing a booking
  form do |f|
    f.inputs 'Booking Details' do
      f.input :user
      f.input :variant
      f.input :status, as: :select, collection: Booking.statuses.keys
      f.input :booking_date, as: :datetime_picker
    end
    f.actions
  end

  # Show page customization
  show do
    attributes_table do
      row :id
      row :user
      row :variant
      row :status
      row :booking_date
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  controller do
    def update
      super do |success, failure|
        if success
          # Check if the status was changed to 'confirmed'
          if resource.saved_change_to_status? && resource.status == 'confirmed'
            variant = Variant.find(resource.variant_id)
            if variant.quantity > 0
              # Decrease the variant quantity by 1
              variant.update(quantity: variant.quantity - 1)
            else
              flash[:alert] = "Cannot confirm booking: Variant out of stock."
              redirect_to admin_booking_path(resource) and return
            end
          end
        end
      end
    end

    private

    def update_variant_quantity(variant_id, change)
      variant = Variant.find(variant_id)
      current_quantity = variant.quantity || 0  # Ensure quantity is not nil
      
      if current_quantity > 0
        new_quantity = current_quantity + change
        variant.update(quantity: new_quantity) if new_quantity >= 0
      else
        flash[:alert] = "Cannot update booking: Variant out of stock."
        redirect_to admin_booking_path(resource) and return
      end
    end
  end
end

