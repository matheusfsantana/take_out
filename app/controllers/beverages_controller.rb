class BeveragesController < ApplicationController
  def index
    @restaurant = user_restaurant
    @beverages = Beverage.where(restaurant: user_restaurant)
  end

  def new 
    @beverage = Beverage.new
  end

  def create 
    @beverage = Beverage.new(beverage_params)
    @beverage.restaurant = user_restaurant

    return redirect_to beverages_path, notice: 'Nova bebida cadastrada com sucesso.' if @beverage.save
    render :new, status: :unprocessable_entity
  end

  def show
    @item = Item.find_by(id: params[:id], restaurant: user_restaurant)
    @beverage = @item
    return redirect_to root_path if @beverage.nil?
    @options = @beverage.item_options
    @button_value = @beverage.is_active ? 'Desativar' : 'Ativar'
  end

  def edit
    @beverage = Beverage.find_by(id: params[:id], restaurant: user_restaurant)
    redirect_to root_path if @beverage.nil?
  end

  def update
    @beverage = Beverage.find_by(id: params[:id], restaurant: user_restaurant)
    return redirect_to beverage_path(@beverage), notice: 'Bebida atualizada com sucesso.' if @beverage.update(beverage_params)
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @beverage = Beverage.find_by(id: params[:id], restaurant: user_restaurant)
    redirect_to beverages_path, notice: "Bebida excluída com sucesso" if @beverage.destroy
  end

  def beverage_params
    params.require(:beverage).permit(:name, :description, :calories, :alcoholic, :image)
  end
end