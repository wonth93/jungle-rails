class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
  
  def show
    @product = Product.all
    @product_total = Product.sum(:quantity)
    @category = Category.all
    @category_total = Category.count
  end
  
end
