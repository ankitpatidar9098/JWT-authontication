class UsersController < ApplicationController
  before_action :authorize_request

  def profile
    render json: @current_user
  end

  private

  def authorize_request
    byebug
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    begin
        byebug
      decoded = JWT.decode(token, Rails.application.secret_key_base)[0]
      @current_user = User.find(decoded["user_id"])
    rescue
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
