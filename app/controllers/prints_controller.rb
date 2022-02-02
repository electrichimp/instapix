class PrintsController < ApplicationController
  def new_book
    @print = Print.new
    @print.product.category = :book
  end

  def new_photo
    @print = Print.new
    @print.product.category = :photo
  end

  def new_frame
    @print = Print.new
    @print.product.category = :frame
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
