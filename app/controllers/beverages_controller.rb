class BeveragesController < ApplicationController
  def index
    @restaurant = user_restaurant
    @beverages = Beverage.where(restaurant: user_restaurant)
  end

  def new 
    @restaurant = user_restaurant
    @beverage = Beverage.new
  end

  def create 
    @restaurant = user_restaurant
    @beverage = Beverage.new(beverage_params)
    @beverage.restaurant = @restaurant

    return redirect_to restaurant_beverages_path(@restaurant), notice: 'Nova bebida cadastrada com sucesso.' if @beverage.save
    render :new, status: :unprocessable_entity
  end

  def show
    @menu_item = MenuItem.find_by(id: params[:id], restaurant: user_restaurant )
    @beverage = @menu_item
    return redirect_to root_path if @beverage.nil?
    @options = @beverage.menu_item_options
    @button_value = @beverage.is_active ? 'Desativar' : 'Ativar'
  end

  def edit
    @restaurant = user_restaurant
    @beverage = Beverage.find_by(id: params[:id], restaurant: user_restaurant)
    redirect_to root_path if @beverage.nil?
  end

  def update
    @beverage = Beverage.find_by(id: params[:id], restaurant: user_restaurant)
    return redirect_to restaurant_beverage_path(user_restaurant, @beverage), notice: 'Bebida atualizada com sucesso.' if @beverage.update(beverage_params)
    @restaurant = user_restaurant
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @beverage = Beverage.find_by(id: params[:id])
    redirect_to restaurant_beverages_path(user_restaurant), notice: "Bebida excluída com sucesso" if @beverage.destroy
  end

  def beverage_params
    params.require(:beverage).permit(:name, :description, :calories, :alcoholic, :image)
  end
end