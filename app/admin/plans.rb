# # ActiveAdmin.register Plan do
# #   permit_params :name, :duration, :price_monthly, :price_yearly, :discount, :discount_type, 
# #                 :discount_percentage, :details, :plan_type, :active, :available

# #   # Index View customization
# #   index do
# #     selectable_column
# #     id_column
# #     column :name
# #     column :plan_type
# #     column :price_monthly
# #     column :price_yearly
# #     column :discount
# #     column :discount_percentage
# #     column :active
# #     actions
# #   end





# #   show do
# #   attributes_table do
# #     row :name
# #     row :plan_type
# #     row :price_monthly
# #     row :price_yearly
# #     row :discount
# #     row :discount_type
# #     row :discount_percentage
# #     row :details
# #     row :active
# #     row :available
# #     row :created_at
# #     row :updated_at

# #     # Debugging outputs
# #     row "Paid plan?" do
# #       plan.paid_plan?.to_s
# #     end

# #     row "Discount present?" do
# #       plan.discount.present?.to_s
# #     end

# #     # If the plan is paid and a discount is present, display the discounted prices
# #     if plan.paid_plan? && plan.discount.present?
# #       row :discounted_price_monthly do
# #         number_to_currency(plan.discounted_price_monthly)
# #       end
# #       row :discounted_price_yearly do
# #         number_to_currency(plan.discounted_price_yearly)
# #       end
# #     else
# #       row "No Discount Applied" do
# #         "Either the plan is not paid or discount is not present."
# #       end
# #     end
# #   end
# # end


# #   # Form customization
# #  form do |f|
# #     f.inputs do
# #       f.input :name
# #       f.input :duration
# #       f.input :plan_type, as: :select, collection: [["Free", "free"], ["Paid", "paid"]], input_html: { id: 'plan_plan_type' }
# #       f.input :details
# #       f.input :price_monthly, input_html: { id: 'plan_price_monthly' }
# #       f.input :price_yearly, input_html: { id: 'plan_price_yearly' }
# #       f.input :discount, as: :select, collection: [["No", false], ["Yes", true]], input_html: { id: 'plan_discount' }
# #       f.input :discount_type, as: :select, collection: ["Percentage", "Fixed"], input_html: { id: 'plan_discount_type' }
# #       f.input :discount_percentage, input_html: { id: 'plan_discount_percentage' }
# #       f.input :active
# #       f.input :available

# #       f.input :discounted_price_monthly, input_html: { readonly: true, id: 'discounted_price_monthly' }, label: "Discounted Price Monthly"
# #       f.input :discounted_price_yearly, input_html: { readonly: true, id: 'discounted_price_yearly' }, label: "Discounted Price Yearly"
# #     end
# #     f.actions
# #   end
# # end




# ActiveAdmin.register Plan do
#   permit_params :name, :months, :price_monthly, :price_yearly, :discount, :discount_type, 
#                 :discount_percentage, :details, :plan_type, :active, :available, :stripe_price_id

#   # Index View customization
#   index do
#     selectable_column
#     id_column
#     column :name
#     column :plan_type
#     column :price_monthly
#     column :price_yearly
#     column :discount
#     column :discount_percentage
#     column :active
#     actions
#   end

#   # Show View customization
#   show do
#     attributes_table do
#       row :name
#       row :plan_type
#       row :price_monthly
#       row :price_yearly
#       row :discount
#       row :discount_type
#       row :discount_percentage
#       row :details
#       row :active
#       row :available
#       row :created_at
#       row :updated_at

#       # Debugging outputs
#       row "Paid plan?" do
#         plan.paid_plan?.to_s
#       end

#       row "Discount present?" do
#         plan.discount.present?.to_s
#       end

#       # Conditional display of discounted prices
#       if plan.paid_plan? && plan.discount.present?
#         row :discounted_price_monthly do
#           number_to_currency(plan.discounted_price_monthly)
#         end
#         row :discounted_price_yearly do
#           number_to_currency(plan.discounted_price_yearly)
#         end
#       else
#         row "No Discount Applied" do
#           "Either the plan is not paid or discount is not present."
#         end
#       end
#     end
#   end

#     filter :subscriptions # This will allow filtering plans by associated subscriptions


#   # Form customization
#   form do |f|
#     f.inputs do
#       f.input :name
#       f.input :months
#       f.input :plan_type, as: :select, collection: [["Free", "free"], ["Paid", "paid"]], input_html: { id: 'plan_plan_type' }
#       f.input :details
#       f.input :price_monthly, input_html: { id: 'plan_price_monthly' }
#       f.input :price_yearly, input_html: { id: 'plan_price_yearly' }
#       f.input :discount, as: :select, collection: [["No", false], ["Yes", true]], input_html: { id: 'plan_discount' }
#       f.input :discount_type, as: :select, collection: ["Percentage", "Fixed"], input_html: { id: 'plan_discount_type' }
#       f.input :discount_percentage, input_html: { id: 'plan_discount_percentage' }
#       f.input :active
#       f.input :available

     
#     end
#     f.actions
#   end
# end

ActiveAdmin.register Plan do
  permit_params :name, :months, :price_monthly, :price_yearly, :discount, 
                :discount_type, :discount_percentage, :details, :plan_type, 
                :active, :available, :stripe_price_id



  filter :subscriptions_id

  # Index View customization
  index do
    selectable_column
    id_column
    column :name
    column :plan_type
    column :price_monthly
    column :price_yearly
    column :discount
    column :discount_percentage
    column :active
    actions
  end

  # Show View customization
  show do
    attributes_table do
      row :name
      row :plan_type
      row :price_monthly
      row :price_yearly
      row :discount
      row :discount_type
      row :discount_percentage
      row :details
      row :active
      row :available
      row :created_at
      row :updated_at

      # Debugging outputs
      row "Paid plan?" do
        plan.paid_plan?.to_s
      end

      row "Discount present?" do
        plan.discount.present?.to_s
      end

      # Conditional display of discounted prices
      if plan.paid_plan? && plan.discount.present?
        row :discounted_price_monthly do
          number_to_currency(plan.discounted_price_monthly)
        end
        row :discounted_price_yearly do
          number_to_currency(plan.discounted_price_yearly)
        end
      else
        row "No Discount Applied" do
          "Either the plan is not paid or discount is not present."
        end
      end
    end
  end

  # Filter customization
  filter :subscriptions # This will allow filtering plans by associated subscriptions

  # Form customization
  form do |f|
    f.inputs do
      f.input :name
      f.input :months
      f.input :plan_type, as: :select, collection: [["Free", "free"], ["Paid", "paid"]]
      f.input :details
      f.input :price_monthly
      f.input :price_yearly
      f.input :discount, as: :select, collection: [["No", false], ["Yes", true]]
      f.input :discount_type, as: :select, collection: ["Percentage", "Fixed"]
      f.input :discount_percentage
      f.input :active
      f.input :available
    end
    f.actions
  end
end

