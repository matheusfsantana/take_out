class HomeController < ApplicationController
  
  def index
    @menus = Menu.where(restaurant_id: params[:restaurant_id])
  end
end