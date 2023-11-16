class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details

  def get_resized_image(size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jp')
      self.image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize: size)
  end

  def with_tax_price
    (price * 1.1).floor
  end
end
