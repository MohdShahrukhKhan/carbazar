class OffersController < ApplicationController
  
      def index
        @offers = Offer.all
        render json: @offers, each_serializer: OfferSerializer
      end


     def create
        @offer = Offer.new(offer_params)

        if @offer.save
          render json: @offer, status: :created, serializer: OfferSerializer
        else
          render json: @offer.errors, status: :unprocessable_entity
        end
     end

  # Other actions...

  private

  def offer_params
    params.require(:offer).permit(:offer_name, :discount, :start_date, :end_date, :variant_id, :feature_id, :car_id)
  end

end
