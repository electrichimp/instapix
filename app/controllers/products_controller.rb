class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]

  def show
    @product = Product.find(params[:id])
  end

  def remember_product
    session[:remembered_print] = { new: true, id: params[:id] }
    redirect_to "https://api.instagram.com/oauth/authorize?client_id=1569528696781232&redirect_uri=https://0667-2001-1388-3c1-7520-c4af-9418-bf1a-d0eb.ngrok.io/instagram/&scope=user_profile,user_media&response_type=code"
  end
end
