class Public::CartItemsController < ApplicationController
  def index
    @cart_item = current_customer
    @cart_items = current_customer.cart_items
  end

  def create
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])

      cart_item.update(amount: cart_item.amount += params[:cart_item][:amount].to_i)
      redirect_to cart_items_path
    else
      cart_item = CartItem.new(cart_item_params)
      cart_item.save!
      redirect_to cart_items_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path(current_customer)
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path(current_customer)
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path(current_customer)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount,)
  end
end
