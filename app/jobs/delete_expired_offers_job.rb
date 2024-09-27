class DeleteExpiredOffersJob < ApplicationJob
  queue_as :default

  def perform
    expired_offers = Offer.where('validity < ?', Date.today)
    expired_offers.destroy_all

    Rails.logger.info("Deleted #{expired_offers.size} expired offers")
  end
end
