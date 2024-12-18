class TagsController < ApplicationController 
  def index 
    @tags = Tag.where(restaurant: user_restaurant)
  end

  def new 
    @tag = Tag.new
  end

  def create 
    @tag = Tag.new(attribute_params)
    @tag.restaurant = user_restaurant

    return redirect_to tags_path, notice: 'Marcador cadastrado com sucesso' if @tag.save 
    flash.now[:alert] = "Erro ao cadastrar marcador"
    render :new, status: :unprocessable_entity
  end

  def edit
    @tag = Tag.find_by(id: params[:id], restaurant: user_restaurant)
    return redirect_to root_path if @tag.nil?
  end

  def update 
    @tag = Tag.find_by(id: params[:id], restaurant: user_restaurant)

    return redirect_to tags_path, notice: 'Marcador atualizado com sucesso' if @tag.update(attribute_params) 
    flash.now[:alert] = "Erro ao atualizar marcador"
    render :edit, status: :unprocessable_entity
  end

  def attribute_params
    params.require(:tag).permit(:name)
  end
end