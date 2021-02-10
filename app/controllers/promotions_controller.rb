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

  def edit
    @promotion = Promotion.find(params[:id])
  end

  def update  
    @promotion = Promotion.find(params[:id])
     
    updated_promotion = params.require(:promotion).permit(:name, :description, :code, 
                                                        :discount_rate, :coupon_quantity, 
                                                        :expiration_date)
    if @promotion.update(updated_promotion)
      redirect_to @promotion
    else
      render 'edit'
    end
  end

  def destroy
    promotion = Promotion.find(params[:id])
    promotion.destroy
    redirect_to promotions_path
  end

  def generate_coupons
    promotion = Promotion.find(params[:id])
    promotion.generate_coupons!
    redirect_to promotion, notice: t('.success')
  end

  def approve
    promotion = Promotion.find(params[:id])
    promotion.approve!(current_user)
    redirect_to promotion
  end
end