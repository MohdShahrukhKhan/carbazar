# app/controllers/brands_controller.rb
class BrandsController < ApplicationController
    before_action :set_brand, only: [:show, :update, :destroy]
  
    # GET /brands
    def index
      @brands = Brand.all
      render json: @brands
    end
  
    # GET /brands/:id
    def show
      render json: @brand
    end
  
    # POST /brands
    def create
      @brand = Brand.new(brand_params)
  
      if @brand.save
        render json: @brand, status: :created
      else
        render json: @brand.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /brands/:id
    def update
      if @brand.update(brand_params)
        render json: @brand
      else
        render json: @brand.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /brands/:id
    def destroy
      @brand.destroy
      head :no_content
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:brand).permit(:name)
    end
  end
  