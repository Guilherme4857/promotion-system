class Promotion < ApplicationRecord
  has_many :coupons
  has_one :promotion_approval
  belongs_to :user
  
  validates :name, :code, :discount_rate, :coupon_quantity, 
            :expiration_date, presence: true
  
  validates :code, uniqueness: true

  validate :must_content_letter, :must_be_uppercase

  def must_content_letter
    characters = Array.new(26){|index|(index + 'A'.ord).chr}

    if code
      code.upcase.each_char do |char| 
        if characters.include? char
          break
        else
          errors.add :code, 'precisa conter letras'
        end
      end
    end
  end

  def must_be_uppercase
    if code
      if code != code.upcase
        errors.add :code, 'precisa ter todas as letras maiúsculas'
      end
    end
  end

  def generate_coupons!
    coupons.transaction do
      Array.new(coupon_quantity){|index|index + 1}.each do |number|
        coupons.create!(code: "#{code}-#{number.to_s.rjust(4, '0')}") 
      end
    end
  end

  def approve!(approval_user)
    return false if approval_user == user
    PromotionApproval.create(promotion: self, user: approval_user)
  end

  def approved?
    promotion_approval
  end

  def approver
    promotion_approval.user
  end
end
