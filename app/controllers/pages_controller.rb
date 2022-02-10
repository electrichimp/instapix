

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
    @client = InstagramBasicDisplay::Client.new

    # short_token_request = @client.short_lived_token(access_code: params[:code])

    # if short_token_request.success?
    #   # token = short_token_request.payload.access_token
    #   # expires_in = short_token_request.payload.expires_in
    #   current_user.instagram_auth_code = short_token_request.payload.access_token
    # else
    #   render json: short_token_request.error, status: 400
    # end

    long_token_request = @client.long_lived_token(access_code: params[:code])
    if long_token_request.success?
      # auth_token = long_token_request.payload.access_token
      # expires_in = long_token_request.payload.expires_in
      current_user.instagram_auth_code = long_token_request.payload.access_token
    else
      render json: long_token_request.error, status: 400
    end
    @client.configuration.auth_token = current_user.instagram_auth_code

    @pages = []
    @pages << @client.media_feed(fields: %i[caption media_url media_count])
    index = 0
    while @pages[index].next_page?
      next_page_link = @pages[index].next_page_link
      @pages << @client.media_feed(fields: %i[caption media_url], paginated_url: next_page_link)
      index += 1
    end
  end

  def my_orders
    @orders = current_user.orders.where.not(state: "pending")
    @paids = current_user.orders.where(state: "paid")
    @printings = current_user.orders.where(state: "printing")
    @delivers = current_user.orders.where(state: "ready_to_deliver")
    @delivered = current_user.orders.where(state: "delivered")
  end



end
#   @body = {
#           client_id: "1569528696781232",
#           client_secret: "d7b0a42139fb4ef764ed47718023a0e8",
#           grant_type: "authorization_code",
#           redirect_uri: "https://cbb5-2001-1388-3c1-7520-dcb6-f211-1b91-735b.ngrok.io/instagram/",
#           code: params[:code]
#   }.to_json
#   @response = Faraday.post('https://api.instagram.com/oauth/access_token', body: @body, headers: {'Content-Type' => 'application/json'})
#   @response = JSON.parse(@response.body)
# end

# curl -X POST \
#   https://api.instagram.com/oauth/access_token \
#   -F client_id=1569528696781232 \
#   -F client_secret=d7b0a42139fb4ef764ed47718023a0e8 \
#   -F grant_type=authorization_code \
#   -F redirect_uri=https://cbb5-2001-1388-3c1-7520-dcb6-f211-1b91-735b.ngrok.io/instagram/ \
#   -F code=AQAWp8daXv-TKPTl_2BBX0gpzbjJY_AIvgd9oj03bWv2oXxUB59mitXdEKNjCjRs5zAb6GuJOggso-g7bRF6NqzbdC3HaP9f-DxeLUeprd_jh7My-MTI5gvMk4o0Wyiq42Gl2iAlK0qanwSN3WqApLECt8K22kPP6owBCvB-IHLFASA4aMcS96zdBEtRCOjLdejlHCBwlJfKdbEMZ4-xaP35swCddWut9tTp3jBdBMCOUg


  #   current_user.instagram_auth_code = params[:code]
  #   body = {
  #           client_id: "1569528696781232",
  #           client_secret: "d7b0a42139fb4ef764ed47718023a0e8",
  #           grant_type: "authorization_code",
  #           redirect_uri: "https://cbb5-2001-1388-3c1-7520-dcb6-f211-1b91-735b.ngrok.io/instagram/",
  #           code: params[:code]
  #   }.to_json
  #   @response = HTTParty.post("https://api.instagram.com/oauth/access_token/",
  #             :body => body,
  #             :headers => {'Content-Type' => 'application/json'})
  #   render :instagram
