class OptionHistoricalsController < ApplicationController
  def index
    @item = Item.find_by(id: params[:item_id], restaurant: user_restaurant)
    @historical = @item.option_historical.order("price_changed_at DESC")
    @path = @item.type == 'Dish' ? dish_path(@item.id) : beverage_path(@item.id)
  end 
end