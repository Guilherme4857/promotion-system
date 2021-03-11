class PromotionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @promotions = Promotion.all
  end
  
  def show
    @promotion = Promotion.find(params[:id])
    @category_name = Promotion.human_attribute_name('product.name')
    @category_code = Promotion.human_attribute_name('product.code')
    @coupon = Coupon.model_name.human
  end

  def new
    @promotion = Promotion.new
    @product_category = ProductCategory.all
    @payment_methods = PaymentMethod.all
  end

  def create
    @promotion = Promotion.new(params.require(:promotion).permit(:name, :description, :code, 
                                                                 :discount_rate, :coupon_quantity, 
                                                                 :expiration_date,
                                                                 product_category_ids:[]))

    @promotion.user = current_user

    if @promotion.save
      redirect_to @promotion
    else
      @product_category = ProductCategory.all
      render 'new'
    end
  end

  def edit
    @promotion = Promotion.find(params[:id])
    @product_category = ProductCategory.all
  end

  def update  
    @promotion = Promotion.find(params[:id])
     
    updated_promotion = params.require(:promotion).permit(:name, :description, :code, 
                                                        :discount_rate, :coupon_quantity, 
                                                        :expiration_date,
                                                        product_category_ids:[])
    if @promotion.update(updated_promotion)
      redirect_to @promotion
    else
      @product_category = ProductCategory.all
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