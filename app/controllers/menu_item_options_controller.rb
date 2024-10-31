class MenuItemOptionsController < ApplicationController
  def new
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    @menu_item = MenuItem.find_by(id: params[:menu_item_id])
    @option = MenuItemOption.new
    @path = @menu_item.type == 'Dish' ? restaurant_dish_path(@restaurant, @menu_item.id) : restaurant_beverage_path(@restaurant, @menu_item.id)
  end

  def create
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    @menu_item = MenuItem.find_by(id: params[:menu_item_id], restaurant_id: @restaurant)
    @option = MenuItemOption.new(menu_item_option_params)
    @option.menu_item = @menu_item

    if @option.save 
      flash[:notice] = 'Porção cadastrada com sucesso.'
      return redirect_to restaurant_dish_path(@restaurant, @menu_item) if @menu_item.type == 'Dish'
      return redirect_to restaurant_beverage_path(@restaurant, @menu_item)
    end
    @path = @menu_item.type == 'Dish' ? restaurant_dish_path(@restaurant, @menu_item.id) : restaurant_beverage_path(@restaurant, @menu_item.id)
    flash.now[:alert] = "Ocorreu um erro ao cadastrar porção"
    render :new, status: :unprocessable_entity
  end


  private 
  def menu_item_option_params
    params.require(:menu_item_option).permit(:description, :price)
  end
end