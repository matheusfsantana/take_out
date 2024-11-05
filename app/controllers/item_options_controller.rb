class ItemOptionsController < ApplicationController
  def new
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    @item = Item.find_by(id: params[:item_id], restaurant: @restaurant)
    @option = ItemOption.new
    @path = @item.type == 'Dish' ? restaurant_dish_path(@restaurant, @item.id) : restaurant_beverage_path(@restaurant, @item.id)
  end

  def create
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    @item = Item.find_by(id: params[:item_id], restaurant_id: @restaurant)
    @option = ItemOption.new(item_options_params)
    @option.item = @item

    if @option.save 
      flash[:notice] = 'Porção cadastrada com sucesso.'
      return redirect_to restaurant_dish_path(@restaurant, @item) if @item.type == 'Dish'
      return redirect_to restaurant_beverage_path(@restaurant, @item)
    end
    @path = @item.type == 'Dish' ? restaurant_dish_path(@restaurant, @item.id) : restaurant_beverage_path(@restaurant, @item.id)
    flash.now[:alert] = "Ocorreu um erro ao cadastrar porção"
    render :new, status: :unprocessable_entity
  end

  def edit
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    @item = Item.find_by(id: params[:item_id], restaurant: @restaurant)
    return redirect_to root_path if @item.nil?
    @option = ItemOption.find_by(id: params[:id], item: @item)
    @path = @item.type == 'Dish' ? restaurant_dish_path(@restaurant, @item.id) : restaurant_beverage_path(@restaurant, @item.id)
  end

  def update
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    @item = Item.find_by(id: params[:item_id], restaurant: @restaurant)
    @option = ItemOption.find_by(id: params[:id], item: @item)
    if @option.update(item_options_params)
      flash[:notice] = 'Porção atualizada com sucesso.'
      return redirect_to restaurant_dish_path(@restaurant, @item) if @item.type == 'Dish'
      return redirect_to restaurant_beverage_path(@restaurant, @item)
    end
    @path = @item.type == 'Dish' ? restaurant_dish_path(@restaurant, @item.id) : restaurant_beverage_path(@restaurant, @item.id)
    flash.now[:alert] = "Ocorreu um erro ao atualizar porção"
    render :edit, status: :unprocessable_entity
  end

  private 
  def item_options_params
    params.require(:item_option).permit(:description, :price)
  end
end