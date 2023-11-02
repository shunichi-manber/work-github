class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @user = current_customer
    if @user.update(user_params)
      redirect_to customers_path
    else
      render :edit
    end
  end

  def check
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,
    :postal_code, :address, :telephone_number, :is_active)
  end
end
