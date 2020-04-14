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
end
