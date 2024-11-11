class RestaurantsController < ApplicationController
  skip_before_action :check_if_user_has_restaurant
  def new 
    @restaurant = Restaurant.new
  end

  def create
    new_restaurant_params = params.require(:restaurant).permit(:corporate_name, :brand_name, :email, :cnpj, :full_address, :phone_number)
    @restaurant = Restaurant.new(new_restaurant_params)
    
    if @restaurant.save
      current_user.update(restaurant: @restaurant)
      return redirect_to root_path, notice: 'Restaurante registrado com sucesso.' 
    end
    
    render :new, status: :unprocessable_entity
  end
end