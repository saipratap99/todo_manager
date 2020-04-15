class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    if current_user
      flash[:notice] = "You're already created account!"
      redirect_to root_path
    end
  end

  def index
    render plain: User.all.map { |user| user.to_pleasant_string }.join("\n")
  end

  def show
    id = params[:id]
    render plain: User.find(id).to_pleasant_string
  end

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    password = params[:password]
    new_user = User.new(first_name: first_name, last_name: last_name, email: email, password: password)
    if new_user.save
      flash[:notice] = "Hello! Welcome #{first_name}"
      session[:current_user_id] = new_user.id
      redirect_to todos_path
    else
      flash[:error] = new_user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def login
    email = params[:email]
    password = params[:password]
    render plain: User.check_crendentials(email, password)
  end

  def edit
    current_user
  end

  def update
    user = current_user
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    current_password = params[:current_password]
    if user.authenticate(current_password)
      if password == password_confirmation
        flash[:notice] = "Password updated successfully"
        user.update!(password: password)
        redirect_to todos_path
      else
        flash[:alert] = "New passwords doesnt match"
        redirect_to edit_user_path
      end
    else
      flash[:alert] = "Your current password is incorrect"
      redirect_to edit_user_path
    end
  end

  def destroy
    current_user.destroy
    session[:current_user_id] = nil
    @current_user = nil
    flash[:notice] = "Your account deleted successfully!Hope you will be back"
    redirect_to root_path
  end
end
