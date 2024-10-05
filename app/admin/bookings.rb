ActiveAdmin.register Booking do
  # Permit the parameters that can be set via the form
  permit_params :user_id, :car_id, :variant_id, :status, :booking_date

  # Filters for searching in the admin panel
  filter :user
  filter :car
  filter :variant
  filter :status, as: :select, collection: -> { Booking.statuses }
  filter :booking_date

  # Customize the index page table
  index do
    selectable_column
    id_column
    column :user
    column :car
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
      f.input :car
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
      row :car
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
      super do |success, _failure|
        # Additional actions can be performed here after the booking is updated
      end
    end
  end

  
end
