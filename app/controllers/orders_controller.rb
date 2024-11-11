class OrdersController < ApplicationController
  def new
    @restaurant = user_restaurant
    @menu = Menu.find_by(restaurant: @restaurant, id: params[:menu_id])
    @items = @menu.items.where(is_active: true)
    @items_options = []
    @items.each do |item|
      item.item_options.each do |option|
        @items_options << option
      end
    end
    @customers = Customer.where(restaurant: @restaurant)
    @order = Order.new
    @order.order_items.build 
  end

  def create
    @restaurant = user_restaurant
    @menu = Menu.find_by(restaurant: @restaurant, id: params[:menu_id])
    @order = Order.new(order_params)
    @order.restaurant = @restaurant
    @order.status = "in_preparation"
  
    if @order.save
      flash[:info] = 'Finalize o pedido.' 
      redirect_to confirm_order_path(@order)
    else
      errors = @order.errors.full_messages.join(", ")
      redirect_to new_restaurant_menu_order_path(@restaurant, @menu), alert: "Erro ao cadastrar pedido: \n#{errors}"
    end
  end

  def confirm_order
    @order = Order.find_by(id: params[:id], restaurant: user_restaurant)
    redirect_to root_path, alert: 'Pedido já confirmado ou inexistente' unless @order.pending_confirmation?
  end

  def confirm_order_status
    @order = Order.find_by(id: params[:id], restaurant: user_restaurant)
    redirect_to root_path, notice: 'Pedido confirmado' if @order.update(status: :pending_kitchen)
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, order_items_attributes: [:id, :item_option_id, :observation])
  end
end