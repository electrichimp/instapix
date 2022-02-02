class PrintsController < ApplicationController
  def new
    session[:current_order] = "probando2"
    @product = Product.find(params[:product_id])
    @print = Print.new(product: @product)
    case @print.product.category
    when "book"
      render :new_book, locals: { product: @product, print: @print }
    when "frame"
      render :new_frame, locals: { product: @product, print: @print }
    when "photo"
      render :new_photo, locals: { product: @product, print: @print }
    end
  end

  def create
    @print = Print.new(print_params)
    @print.order_id = session[:current_order]
    @print.save
    redirect_to root_path
    # if @print.save

    # else

    # end
  end



  private

  def print_params
    params.require(:print).permit(:product_id, :order_id, :title, :cover_photo, photos: [])
  end
end
