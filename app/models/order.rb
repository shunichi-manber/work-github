class Order < ApplicationRecord

  has_many :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
end
