class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end
  
  def show
    @promotion = Promotion.find(params[:id])
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(params.require(:promotion).permit(:name, :description, :code, 
                                                                 :discount_rate, :coupon_quantity, :expiration_date))
    if @promotion.save
      redirect_to @promotion
    else
      render 'new'
    end
  end
end