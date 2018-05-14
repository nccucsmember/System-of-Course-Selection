class ApiController < ActionController::Base

  protect_from_forgery with: :null_session
  before_action :authenticate_user_from_token!
  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers

  def show

  end

  def authenticate_user_from_token!

    if params[:auth_token].present?
      user = User.find_by_authentication_token( params[:auth_token] )

      # Devise: 設定 current_user
      sign_in(user, store: false) if user
    end

  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      
    end
  end

end
