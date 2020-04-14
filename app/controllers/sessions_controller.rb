class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      flash[:notice] = "Your login is successful!"
      redirect_to todos_path
    elsif user
      flash[:alert] = "Invalid email and password"
      redirect_to new_session_path
    else
      flash[:alert] = "Account associated with #{params[:email]} not found"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    flash[:notice] = "Your logged out is successfully!"
    redirect_to root_path
  end
end
