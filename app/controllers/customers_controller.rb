class CustomersController < ApplicationController
  def index
    @sales = Sale.all
    @customers = Customer.all
  end

  def show
    @customers = Customer.find(params[:id])
  end
end
