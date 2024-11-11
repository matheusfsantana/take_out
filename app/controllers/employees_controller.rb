class EmployeesController < ApplicationController
  
  def index 
    @employees = Employee.where(restaurant: user_restaurant)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.restaurant = user_restaurant
    return redirect_to employees_path, notice: 'Pré-cadastro realizado com sucesso' if @employee.save

    flash.now[:alert] = 'Erro ao realizar pré-cadastro'
    render :new, status: :unprocessable_entity
  end

  private
  def employee_params
    params.require(:employee).permit(:cpf, :email)
  end
end