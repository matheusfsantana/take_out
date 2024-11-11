class BussinessHoursController < ApplicationController 
  def index 
    @bussiness_hours = BussinessHour.where(restaurant: user_restaurant)
  end
  def edit 
    @bussiness_hour = BussinessHour.find_by(params[:id], restaurant: user_restaurant) 
  end

  def update
    @bussiness_hour = BussinessHour.find_by(params[:id], restaurant: user_restaurant)
    return redirect_to bussiness_hours_path, notice: 'Horário atualizado com sucesso' if @bussiness_hour.update(bussiness_hour_params)
    render :edit, status: :unprocessable_entity
  end

  private
  def bussiness_hour_params
    params.require(:bussiness_hour).permit(:opening_hour, :closing_hour, :is_open)
  end
end