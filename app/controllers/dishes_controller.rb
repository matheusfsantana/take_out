class DishesController < ApplicationController
  
  def index 
    @dishes = Dish.where(restaurant: user_restaurant)
    @tags = Tag.where(restaurant: user_restaurant)
    if params[:filter_tag].present?
      @dishes = Dish.joins(:item_tags, :tags)
                    .where(restaurant: user_restaurant)
                    .where(tags: { name: params[:filter_tag] })
                    .distinct
    end
  end

  def new
    @dish = Dish.new
    @tags = Tag.where(restaurant: user_restaurant)
  end
  
  def create
    @dish = Dish.new(dish_params)
    @dish.restaurant = user_restaurant

    return redirect_to dishes_path, notice: 'Novo prato cadastrado com sucesso.' if @dish.save
    @tags = Tag.where(restaurant: user_restaurant)
    render :new, status: :unprocessable_entity
  end
  
  def show
    @item = Item.find_by(id: params[:id], restaurant: user_restaurant )
    @dish = @item
    return redirect_to root_path if @dish.nil?
    @tags = @dish.tags
    @options = @dish.item_options
    @button_value = @dish.is_active ? 'Desativar' : 'Ativar'
  end

  def edit
    @dish = Dish.find_by(id: params[:id], restaurant: user_restaurant)
    @tags = Tag.where(restaurant: user_restaurant)
    redirect_to root_path if @dish.nil?
  end

  def update
    @dish = Dish.find_by(id: params[:id], restaurant: user_restaurant)
    return redirect_to dish_path(@dish), notice: 'Prato atualizado com sucesso.' if @dish.update(dish_params)
    @tags = Tag.where(restaurant: user_restaurant)
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @dish = Dish.find_by(id: params[:id])
    redirect_to dishes_path, notice: "Prato excluído com sucesso" if @dish.destroy
  end

  private
  def dish_params
    params.require(:dish).permit(:name, :description, :calories, :image, tag_ids: [])
  end
end