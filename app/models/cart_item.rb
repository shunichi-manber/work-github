class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def item_name
    item.name
  end

  def item_with_tax_price
    item.with_tax_price
  end

  def item_image
    item.image
  end
  
  def subtotal
    item.with_tax_price * amount
  end

end
