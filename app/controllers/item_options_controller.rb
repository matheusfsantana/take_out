class ItemOptionsController < ApplicationController
  def new
    @item = Item.find_by(id: params[:item_id], restaurant: user_restaurant)
    @option = ItemOption.new
    @path = @item.type == 'Dish' ? dish_path(@item.id) : beverage_path(@item.id)
  end

  def create
    @item = Item.find_by(id: params[:item_id], restaurant_id: user_restaurant)
    @option = ItemOption.new(item_options_params)
    @option.item = @item

    if @option.save 
      flash[:notice] = 'Porção cadastrada com sucesso.'
      return redirect_to dish_path(@item) if @item.type == 'Dish'
      return redirect_to beverage_path(@item)
    end
    @path = @item.type == 'Dish' ? dish_path(@item) : beverage_path(@item)
    flash.now[:alert] = "Ocorreu um erro ao cadastrar porção"
    render :new, status: :unprocessable_entity
  end

  def edit
    @item = Item.find_by(id: params[:item_id], restaurant: user_restaurant)
    return redirect_to root_path if @item.nil?
    @option = ItemOption.find_by(id: params[:id], item: @item)
    @path = @item.type == 'Dish' ? dish_path(@item.id) : beverage_path(@item.id)
  end

  def update
    @item = Item.find_by(id: params[:item_id], restaurant: user_restaurant)
    @option = ItemOption.find_by(id: params[:id], item: @item)
    if @option.update(item_options_params)
      flash[:notice] = 'Porção atualizada com sucesso.'
      return redirect_to dish_path(@item) if @item.type == 'Dish'
      return redirect_to beverage_path(@item)
    end
    @path = @item.type == 'Dish' ? dish_path(@item.id) : beverage_path(@item.id)
    flash.now[:alert] = "Ocorreu um erro ao atualizar porção"
    render :edit, status: :unprocessable_entity
  end

  private 
  def item_options_params
    params.require(:item_option).permit(:description, :price)
  end
end