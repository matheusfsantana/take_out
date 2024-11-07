class HomeController < ApplicationController
  
  def index
    @restaurant = user_restaurant
    @menus = Menu.where(restaurant: @restaurant)
  end
end