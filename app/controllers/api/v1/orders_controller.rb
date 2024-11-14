class Api::V1::OrdersController < ActionController::API
  before_action :set_restaurant

  def index
    order = if params[:status].present? && Order.statuses.keys.include?(params[:status])
      Order.where(restaurant: @restaurant, status: params[:status]).order(order_date: :asc)
    else
      Order.where(restaurant: @restaurant).order(:status, order_date: :asc)
    end

    order_details = order.as_json(
      only: [:id, :status, :code, :order_date, :total],
      include: [
        customer: { only: [:name, :phone_number, :email] },
        order_items: {
          only: [:price_at_order, :observation],  
          methods: [:description]
        }
      ]
    )
    order_details.each { |order| order['status'] = Order.human_enum_name(:status, order['status']) }

    render json: order_details, status: :ok
  end

  def show
    order = Order.find_by(restaurant: @restaurant, code: params[:code])
    
    if order.nil?
      return render json: { error: 'Order not found' }, status: :not_found
    end

    order_details = order.as_json(
      only: [:id, :status, :code, :order_date, :total],
      include: [
        customer: { only: [:name, :phone_number, :email] },
        order_items: {
          only: [:price_at_order, :observation],  
          methods: [:description]
        }
      ]
    )
    order_details['status'] = Order.human_enum_name(:status, order.status)


    render json: order_details, status: :ok
  end

  def to_preparation
    order = Order.find_by(restaurant: @restaurant, code: params[:code])
    
    if order.nil?
      return render json: { error: 'Order not found' }, status: :not_found
    end

    order.in_preparation!
    order_details = order.as_json(
      only: [:id, :status, :code, :order_date, :total],
      include: [
        customer: { only: [:name, :phone_number, :email] },
        order_items: {
          only: [:price_at_order, :observation],  
          methods: [:description]
        }
      ]
    )
    order_details['status'] = Order.human_enum_name(:status, order.status)

    render json: order_details, status: :ok
  end

  def to_ready
    order = Order.find_by(restaurant: @restaurant, code: params[:code])
    
    if order.nil?
      return render json: { error: 'Order not found' }, status: :not_found
    end

    order.ready!
    order_details = order.as_json(
      only: [:id, :status, :code, :order_date, :total],
      include: [
        customer: { only: [:name, :phone_number, :email] },
        order_items: {
          only: [:price_at_order, :observation],  
          methods: [:description]
        }
      ]
    )
    order_details['status'] = Order.human_enum_name(:status, order.status)
    render json: order_details, status: :ok
  end

  private
  def set_restaurant
    @restaurant = Restaurant.find_by(code: params[:restaurant_code])
    render json: { error: 'Restaurant not found' }, status: :not_found unless @restaurant
  end
end