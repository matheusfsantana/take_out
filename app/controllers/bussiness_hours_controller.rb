class BussinessHoursController < ApplicationController 
  def index 
    @restaurant = user_restaurant
    @bussiness_hours = BussinessHour.where(restaurant: @restaurant)
  end
  def edit 
    @restaurant = user_restaurant
    @bussiness_hour = BussinessHour.find(params[:id]) 
  end

  def update
    @restaurant = user_restaurant
    @bussiness_hour = BussinessHour.find(params[:id])

    return redirect_to restaurant_bussiness_hours_path(@restaurant), notice: 'Horário atualizado com sucesso' if @bussiness_hour.update(bussiness_hour_params)
    
    render :edit, status: :unprocessable_entity
  end

  private
  def bussiness_hour_params
    params.require(:bussiness_hour).permit(:opening_hour, :closing_hour, :is_open)
  end
end