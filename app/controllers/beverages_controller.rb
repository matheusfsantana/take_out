class BeveragesController < ApplicationController
  def index
    @restaurant = user_restaurant
    @beverages = Beverage.all
  end

  def show
    
  end
end