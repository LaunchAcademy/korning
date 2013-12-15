class ProductsController < ApplicationController
  def index
    @sales = Sale.where(['sale_date > ?', Date.today - 455]).order(:sale_date)
  end

  def show
    @products = Product.find(params[:id])
  end
  
end
