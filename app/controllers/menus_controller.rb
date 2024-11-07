class MenusController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.new
    @dishes = Item.where(restaurant: @restaurant, type: 'Dish')
    @beverages = Item.where(restaurant_id: @restaurant, type: 'Beverage')
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.new(menu_params)
    @menu.restaurant = @restaurant

    return redirect_to root_path(@restaurant), notice: 'Cardápio cadastrado com sucesso' if @menu.save 
    @dishes = Item.where(restaurant: @restaurant, type: 'Dish')
    @beverages = Item.where(restaurant_id: @restaurant, type: 'Beverage')
    flash.now[:alert] = "Erro ao cadastrar cardápio"
    render :new, status: :unprocessable_entity
  end

  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.find_by(id: params[:id], restaurant: @restaurant)
    @dishes = @menu.items.where(is_active: true, type: 'Dish')
    @beverages = @menu.items.where(is_active: true, type: 'Beverage')
    
    @dishes_options = []
    @dishes.each do |dish|
      dish.item_options.each do |option|
        @dishes_options << option
      end
    end
    
    @beverages_options = []
    @beverages.each do |beverage|
      beverage.item_options.each do |option|
        @beverages_options << option
      end
    end
  end

  private
  def menu_params
    params.require(:menu).permit(:name, item_ids: [])
  end
end
