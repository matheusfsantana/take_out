class TagsController < ApplicationController 
  def index 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @tags = Tag.where(restaurant: @restaurant)
  end

  def new 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @tag = Tag.new
  end

  def create 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @tag = Tag.new(attribute_params)
    @tag.restaurant = @restaurant

    return redirect_to restaurant_tags_path(@restaurant), notice: 'Marcador cadastrado com sucesso' if @tag.save 
    flash.now[:alert] = "Erro ao cadastrar marcador"
    render :new, status: :unprocessable_entity
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @tag = Tag.find_by(id: params[:id], restaurant: @restaurant)
    return redirect_to root_path if @tag.nil?
  end

  def update 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @tag = Tag.find_by(id: params[:id], restaurant: @restaurant)

    return redirect_to restaurant_tags_path(@restaurant), notice: 'Marcador atualizado com sucesso' if @tag.update(attribute_params) 
    flash.now[:alert] = "Erro ao atualizar marcador"
    render :edit, status: :unprocessable_entity
  end

  def attribute_params
    params.require(:tag).permit(:name)
  end
end