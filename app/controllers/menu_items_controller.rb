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

  def update_status
    menu_item = MenuItem.find(params[:menu_item_id])
    menu_item.update(is_active: !menu_item.is_active)

    status = menu_item.is_active ? 'Ativo' : 'Inativo'
    flash[:notice] = "Status atualizado com sucesso para: #{status}" 
    return redirect_to restaurant_dish_path(user_restaurant, menu_item) if menu_item.type == 'Dish'
    redirect_to restaurant_beverage_path(user_restaurant, menu_item) if menu_item.type == 'Beverage'
  end
end