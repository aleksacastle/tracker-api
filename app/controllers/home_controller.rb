class HomeController < ApplicationController
  skip_before_action :authorize_request

  def index
    render json: { message: Message.welcome}
  end
end
