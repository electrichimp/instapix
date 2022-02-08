class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @products = Product.all
  end

  def cart
    @order = pending_order
    @total_price = @order.prints.where(complete: true).map{ |p| p.product.base_price }.sum
  end

  def drafts
    @prints = print_drafts
  end

  def about_us

  end

  def instagram
    current_user.instagram_auth_code = params[:code]
    render :home
  end
end
