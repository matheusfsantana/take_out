class CustomersController < ApplicationController
  skip_before_action :redirect_if_is_employee
  def new
    session[:previous_path] = request.referer 
    @previous_path = session[:previous_path]
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.restaurant =  user_restaurant
    return redirect_to session.delete(:previous_path)  || root_path, notice: 'Cliente cadastrado com sucesso' if @customer.save

    flash.now[:alert] = 'Não foi possível cadastrar o cliente'
    @previous_path = session[:previous_path]
    render :new, status: :unprocessable_entity
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :cpf, :phone_number, :email)
  end
end