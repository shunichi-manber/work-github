class Public::CustomersController < ApplicationController

  def show
    @user = current_customer
  end

  def edit
  end

  private

  def user_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,
    :postal_code, :address, :telephone_number)
  end
end
