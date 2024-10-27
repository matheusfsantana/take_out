class BeveragesController < ApplicationController
  def index
    @restaurant = user_restaurant
    @beverages = Beverage.all
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
    
  end

  def beverage_params
    params.require(:beverage).permit(:name, :description, :calories, :alcoholic, :image)
  end
end