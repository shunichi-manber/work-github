class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    #flash[:notice] = "ようこそ"
    customers_path
  end

  def after_sign_out_path_for(resource)
    #flash[:notice] = "Signed out successfully."
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana,
    :postal_code, :address, :telephone_number, :is_active])
  end

  def customer_state
  # 【処理内容1】 入力されたemailからアカウントを1件取得
  @customer = Customer.find_by(email: params[:customer][:email])
  # アカウントを取得できなかった場合、このメソッドを終了する
  return if !@customer
  # 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
  if @customer.valid_password?(params[:customer][:password])
    # 【処理内容3】
    if @customer.is_active
      redirect_to new_customer_registration_path
    else
      sign_in @customer
      redirect_to root_path
    end
  end
  end
end
