class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_if_user_has_restaurant, unless: :devise_controller?
  before_action :redirect_unless_owner
 
  protected
  def check_if_user_has_restaurant
    if user_signed_in? && !Restaurant.exists?(user: current_user)
      flash[:info] = 'É necessário registrar seu restaurante antes de prosseguir.'
      return redirect_to new_restaurant_path
    end
  end

  def user_restaurant
    Restaurant.find_by(user: current_user)
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf])
  end

  def redirect_unless_owner
    if params[:restaurant_id].present?
      redirect_to root_path unless params[:restaurant_id].to_i == user_restaurant.id
    end
  end
end
