class PrintsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @print = Print.new(product: @product)
    @new = true
    case @print.product.category
    when "book"
      render :book_editor
    when "frame"
      render :frame_editor
    when "photo"
      render :photo_editor
    end
  end

  def create
    @print = Print.new(print_params)
    @print.order = pending_order
    @print.product = Product.find(params[:product_id])
    if @print.save
      redirect_to edit_print_path(@print)
    else
      render :new
    end
  end

  def edit
    @print = Print.find(params[:id])
    case @print.product.category
    when "book"
      render :book_editor
    when "frame"
      render :frame_editor
    when "photo"
      render :photo_editor
    end
  end

  def update
    @print = Print.find(params[:id])
    @print.photos.attach(params[:print][:photos]) if params[:print][:photos].present?
    @print.cover_photo.attach(params[:print][:cover_photo]) if params[:print][:cover_photo].present?
    @print.save
    @print.update(title: print_params[:title])
    case @print.product.category
    when "book"
      render :book_editor
    when "frame"
      render :frame_editor
    when "photo"
      render :photo_editor
    end
  end

  def destroy
    @print = Print.find(params[:id])
    @print.destroy
    redirect_to cart_path
  end

  private

  def print_params
    params.require(:print).permit(:product_id, :order_id, :title, :cover_photo, photos: [])
  end
end
