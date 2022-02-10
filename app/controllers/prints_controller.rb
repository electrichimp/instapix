require "open-uri"

class PrintsController < ApplicationController
  skip_before_action :verify_authenticity_token
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
      case @print.product.category
      when "book"
        render :book_editor
      when "frame"
        render :frame_editor
      when "photo"
        render :photo_editor
      end
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
    if print_params[:photos] || print_params[:cover_photo] || print_params[:title]
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
    else
      case @print.product.category
      when "book"
        render :book_editor
      when "frame"
        render :frame_editor
      when "photo"
        render :photo_editor
      end
    end
  end

  def complete
    @print = Print.find(params[:id])
    @print.complete = true
    @print.save
    redirect_to cart_path
  end

  def destroy
    @print = Print.find(params[:id])
    @print.destroy
    redirect_to cart_path
  end

  def trash_pic
    @print = Print.find(params[:id])
    persisted_photos = @print.photos.reject {|photo| photo.key == params[:key]}
    persisted_photos_blob = persisted_photos.map {|photo| photo.blob}
    @print.photos.detach
    @print.photos.attach persisted_photos_blob
    redirect_to edit_print_path(@print)
  end

  def remember_print
    session[:remembered_print] = { new: false, id: params[:id] }
    redirect_to "https://api.instagram.com/oauth/authorize?client_id=1569528696781232&redirect_uri=https://0667-2001-1388-3c1-7520-c4af-9418-bf1a-d0eb.ngrok.io/instagram/&scope=user_profile,user_media&response_type=code"
  end

  def upload_instagram
    # byebug
    urls = params[:urls]
    if session[:remembered_print]["new"] == true
      product = Product.find(session[:remembered_print]["id"])
      print = Print.create(product: product, order: pending_order)
    else
      print = Print.find(session[:remembered_print]["id"])
    end
    urls.each do |url|
      file = URI.open(url)
      print.photos.attach(io: file, filename: "from_instagram", content_type: 'image/png')
    end
    print.save
    session[:remembered_print] = nil
    render json: { url: edit_print_url(print) }.to_json
  end

  private

  def print_params

    params.require(:print).permit(:product_id, :order_id, :title, :cover_photo, photos: [])
  end
end
