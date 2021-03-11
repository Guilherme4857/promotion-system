class Api::V1::CouponsController < Api::V1::ApiController
  def show
    coupon = Coupon.find_by(code: params[:id])
    if coupon.nil?
      render status: 404, json: "{ msg: 'coupon not found' }"  
    else
      render json: coupon.as_json(
        only: [:code, :status], include: :promotion
      ), status: 200        
    end
  end
end