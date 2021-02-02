class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end
  def show
    @promotion = Promotion.find(params[:id])
  end
  def new
  end
  def create
    @promotion = Promotion.new(params.require(:promotion).permit(:name, 
                 :description, :code, :discount_rate, :coupon_quantity, :expiration_date))
    @promotion.save
    redirect_to promotion_path(@promotion)
  end
end