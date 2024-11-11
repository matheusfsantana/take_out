class HomeController < ApplicationController
  skip_before_action :redirect_if_is_employee
  
  def index
    @menus = Menu.where(restaurant: user_restaurant)
  end
end