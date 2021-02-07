class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: {active: 0, inactivate: 10}
end
