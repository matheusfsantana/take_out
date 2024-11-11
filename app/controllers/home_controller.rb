class HomeController < ApplicationController
  skip_before_action :redirect_if_is_employee
  
  def index
    @restaurant = user_restaurant
    @menus = Menu.where(restaurant: @restaurant)
  end
end