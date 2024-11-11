class MenusController < ApplicationController
  skip_before_action :redirect_if_is_employee
  
  def new
    @menu = Menu.new
    @dishes = Item.where(restaurant: user_restaurant, type: 'Dish')
    @beverages = Item.where(restaurant: user_restaurant, type: 'Beverage')
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.restaurant = user_restaurant

    return redirect_to root_path, notice: 'Cardápio cadastrado com sucesso' if @menu.save 
    @dishes = Item.where(restaurant: user_restaurant, type: 'Dish')
    @beverages = Item.where(restaurant: user_restaurant, type: 'Beverage')
    flash.now[:alert] = "Erro ao cadastrar cardápio"
    render :new, status: :unprocessable_entity
  end

  def show
    @menu = Menu.find_by(id: params[:id], restaurant: user_restaurant)
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
