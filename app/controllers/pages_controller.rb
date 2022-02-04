class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @products = Product.all
  end

  def cart
    @order = pending_order
  end

  def drafts
    @prints = print_drafts
  end

  def about_us

  end
end
