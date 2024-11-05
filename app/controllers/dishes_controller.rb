class DishesController < ApplicationController
  
  def index 
    @restaurant = user_restaurant
    @dishes = Dish.where(restaurant: user_restaurant)
    @tags = Tag.where(restaurant: @restaurant)
    if params[:filter_tag].present?
      @dishes = Dish.joins(:item_tags, :tags)
                    .where(restaurant: user_restaurant)
                    .where(tags: { name: params[:filter_tag] })
                    .distinct
    end
  end

  def new
    @restaurant = user_restaurant
    @dish = Dish.new
    @tags = Tag.where(restaurant: @restaurant)
  end
  
  def create
    @restaurant = user_restaurant
    @dish = Dish.new(dish_params)
    @dish.restaurant = @restaurant

    return redirect_to restaurant_dishes_path(@restaurant), notice: 'Novo prato cadastrado com sucesso.' if @dish.save
    @tags = Tag.where(restaurant: @restaurant)
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
    @restaurant = user_restaurant
    @dish = Dish.find_by(id: params[:id], restaurant: user_restaurant)
    @tags = Tag.where(restaurant: @restaurant)
    redirect_to root_path if @dish.nil?
  end

  def update
    @dish = Dish.find_by(id: params[:id], restaurant: user_restaurant)
    return redirect_to restaurant_dish_path(user_restaurant, @dish), notice: 'Prato atualizado com sucesso.' if @dish.update(dish_params)
    @restaurant = user_restaurant
    @tags = Tag.where(restaurant: @restaurant)
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @dish = Dish.find_by(id: params[:id])
    redirect_to restaurant_dishes_path(user_restaurant), notice: "Prato excluído com sucesso" if @dish.destroy
  end

  private
  def dish_params
    params.require(:dish).permit(:name, :description, :calories, :image, tag_ids: [])
  end
end