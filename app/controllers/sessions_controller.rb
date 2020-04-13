class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      redirect_to root_path
    else
      render plain: "Invalid email and password"
    end
  end
end
