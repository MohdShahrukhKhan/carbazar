class DealersController < ApplicationController
    before_action :set_dealer, only: %i[show edit update destroy]
  
    def index
      @dealers = Dealer.all
      render json: @dealers
    end
  
    def show
      render json: @dealer
    end
  
    def create
      @dealer = Dealer.new(dealer_params)
      if @dealer.save
        render json: @dealer, status: :created
      else
        render json: @dealer.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @dealer.update(dealer_params)
        render json: @dealer
      else
        render json: @dealer.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @dealer.destroy
      head :no_content
    end
  
    private
  
    def set_dealer
      @dealer = Dealer.find(params[:id])
    end
  
    def dealer_params
      params.require(:dealer).permit(:name, :address, :contact_number, :brand_id)
    end
  end
  