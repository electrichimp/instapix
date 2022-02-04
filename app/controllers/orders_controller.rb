class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def pay
    @order = Order.find(params[:id])
    @order.state = "paid"
    @order.save
    new_order = pending_order
    uncomplete_prints = current_user.prints.where(complete: false)
    uncomplete_prints.each do |print|
      print.order = new_order
      print.save
    end
    redirect_to root_path
  end

end
