class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def info
    @order = Order.new(order_params)
    if params[:order][:serect_address] == "0"
      @order.post_code = current_customer.postal_code + current_costomer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:serect_address] == "2"
      @order.customer_id = current_customer.id
    end
      @cart_items = current_customer.cart_items
      @order_new = Order.new
      render :info
  end

  def index
  end

  def show
  end

  def create
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.price_excluding_tax
      @order_details.pieces = cart_item.amount
      @order_details.save!
    end

    CartItem.destroy_all
    redirect_to complete_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :post_code, :name, :payment_amount, :postage, :payment_method)
  end

  def cartitem_nill
    cart_items = current_customer.cart_items
    if cart_items.blank?
      redirect_to cart_items_path
    end
  end
end
