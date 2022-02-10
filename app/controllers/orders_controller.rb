class OrdersController < ApplicationController

  def index
    @orders = Order.where.not(state: "pending")
    @paids = Order.where(state: "paid")
    @printings = Order.where(state: "printing")
    @delivers = Order.where(state: "ready_to_deliver")
    @delivered = Order.where(state: "delivered")
    @cancelled_orders = Order.where(state: "cancelled")
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to orders_path
  end


  def ship
    @order = Order.find(params[:id])
    @total_price = @order.prints.where(complete: true).map{ |p| p.product.base_price }.sum
    @order.update(order_params)
    @order.state = "paid"
    @order.purchase_date = Date.new
    @order.total_price = 1000
    @order.total_price = @order.prints.where(complete: true).map{ |p| p.product.base_price }.sum
    @order.save
    new_order = pending_order
    uncomplete_prints = current_user.prints.where(complete: false)
    uncomplete_prints.each do |print|
      print.order = new_order
      print.save
    end
  end

  def pay
    @order = Order.find(params[:id])
    @order.state = "paid"
    @order.purchase_date = Time.new
    @order.total_price = 1000
    @order.total_price = @order.prints.where(complete: true).map{ |p| p.product.base_price }.sum + 5
    @order.save
    new_order = pending_order
    uncomplete_prints = current_user.prints.where(complete: false)
    uncomplete_prints.each do |print|
      print.order = new_order
      print.save
    end
  end

  private

  def order_params
    params.require(:order).permit(:shipping_address, :state)
  end
end
