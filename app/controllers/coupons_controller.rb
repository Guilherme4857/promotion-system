class CouponsController < ApplicationController
  def inactivate
    @coupon = Coupon.find(params[:id])

    redirect_to @coupon.promotion
  end
end