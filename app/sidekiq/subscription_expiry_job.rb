
# class SubscriptionExpiryJob
#   include Sidekiq::Job

#   def perform(subscription_id)
#     subscription = Subscription.find_by(id: subscription_id)

#     if subscription && subscription.expires_at <= Time.current
#       subscription.destroy
#       # Optionally, notify the user that their subscription has expired
#       UserMailer.subscription_expired(subscription.user).deliver_later if subscription.user
#     end
#   end
# end

class SubscriptionExpiryJob
  include Sidekiq::Job

  def perform(subscription_id)
    subscription = Subscription.find_by(id: subscription_id)

    if subscription&.expires_at <= Time.current
      subscription.destroy!
      UserMailer.subscription_expired(subscription.user).deliver_later if subscription.user.present?
    end
  end
end


