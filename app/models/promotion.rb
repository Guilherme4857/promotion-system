class Promotion < ApplicationRecord
  has_many :coupons
  
  validates :name, :code, :discount_rate, :coupon_quantity, 
            :expiration_date, presence: true
  
  validates :code, uniqueness: true

  def generate_coupons!
    coupons.transaction do
      Array.new(coupon_quantity){|index|index + 1}.each do |number|
        coupons.create!(code: "#{code}-#{number.to_s.rjust(4, '0')}") 
      end
    end

  end
end
