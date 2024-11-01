class OptionHistoricalsController < ApplicationController
  def index
    restaurant_id = params[:restaurant_id]
    @menu_item = MenuItem.find_by(id: params[:menu_item_id], restaurant_id: restaurant_id)
    @historical = @menu_item.option_historical.order("price_changed_at DESC")
    @path = @menu_item.type == 'Dish' ? restaurant_dish_path(restaurant_id, @menu_item.id) : restaurant_beverage_path(restaurant_id, @menu_item.id)
  end 
end