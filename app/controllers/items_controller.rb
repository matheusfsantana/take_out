class ItemsController < ApplicationController
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

  def update_status
    item = Item.find(params[:item_id])
    item.update(is_active: !item.is_active)

    status = item.is_active ? 'Ativo' : 'Inativo'
    flash[:notice] = "Status atualizado com sucesso para: #{status}" 
    return redirect_to restaurant_dish_path(user_restaurant, item) if item.type == 'Dish'
    redirect_to restaurant_beverage_path(user_restaurant, item) if item.type == 'Beverage'
  end
end