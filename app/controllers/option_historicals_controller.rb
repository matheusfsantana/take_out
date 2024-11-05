class OptionHistoricalsController < ApplicationController
  def index
    restaurant_id = params[:restaurant_id]
    @item = Item.find_by(id: params[:item_id], restaurant_id: restaurant_id)
    @historical = @item.option_historical.order("price_changed_at DESC")
    @path = @item.type == 'Dish' ? restaurant_dish_path(restaurant_id, @item.id) : restaurant_beverage_path(restaurant_id, @item.id)
  end 
end