class MenuItemsController < ApplicationController
  def search
    @search = params[:query]
    if @search.empty?
      @dishes = nil
      @beverages = nil
    else
      @dishes = Dish.where(restaurant: user_restaurant)
                    .where("name LIKE ? OR description LIKE ?", "%#{@search}%", "%#{@search}%")
      @beverages = Beverage.where(restaurant: user_restaurant)
                           .where("name LIKE ? OR description LIKE ?", "%#{@search}%", "%#{@search}%")
    end
  end
end