class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = Address.all
  end

  def info
    @order = Order.new(order_params)
    if params[:order][:serect_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_costomer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:serect_address] == "2"
      @order.customer_id = current_customer.id
    end
      @cart_items = current_customer.cart_items
      @order_new = Oder.new
      render :info
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:post_code, :name, :payment_amount, :postage)
  end
end
