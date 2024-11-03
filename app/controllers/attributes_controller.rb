class AttributesController < ApplicationController 
  def index 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @attributes = Attribute.where(restaurant: @restaurant)
  end

  def new 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @attribute = Attribute.new
  end

  def create 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @attribute = Attribute.new(attribute_params)
    @attribute.restaurant = @restaurant

    return redirect_to restaurant_attributes_path(@restaurant), notice: 'Marcador cadastrado com sucesso' if @attribute.save 
    flash.now[:alert] = "Erro ao cadastrar marcador"
    render :new, status: :unprocessable_entity
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @attribute = Attribute.find_by(id: params[:id], restaurant: @restaurant)
    return redirect_to root_path if @attribute.nil?
  end

  def update 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @attribute = Attribute.find_by(id: params[:id], restaurant: @restaurant)

    return redirect_to restaurant_attributes_path(@restaurant), notice: 'Marcador atualizado com sucesso' if @attribute.update(attribute_params) 
    flash.now[:alert] = "Erro ao atualizar marcador"
    render :edit, status: :unprocessable_entity
  end

  def attribute_params
    params.require(:attribute).permit(:name)
  end
end