class PromotionsController < ApplicationController
  before_action :authenticate_user!
  
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
                                                                 :discount_rate, :coupon_quantity, 
                                                                 :expiration_date))

    @promotion.user = current_user

    if @promotion.save
      redirect_to @promotion
    else
      render 'new'
    end
  end

  def generate_coupons
    @promotion = Promotion.find(params[:id])
    @promotion.generate_coupons!
    redirect_to @promotion, notice: t('.success')
  end
end