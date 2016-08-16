class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV['BFRFFQTGVIOWDNVDQIZZ1JRTQ5W5ZP5LBFGMOWZ3TTORIPXI']
      req.params['client_secret'] = ENV['5MOB5YFTIGOWMQHOK2HCVQTHLALYZH2MCIM1DN0YGXKLRM5B']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
