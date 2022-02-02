class PrintsController < ApplicationController
  def new
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
    if @print.save

    else

    end
  end



  private

  def print_params
    params.require(:print).permit(:title, :cover_photo, photos: [])
  end
end
