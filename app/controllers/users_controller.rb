class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
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
    new_user = User.create!(first_name: first_name, last_name: last_name, email: email, password: password)
    redirect_to root_path
  end

  def login
    email = params[:email]
    password = params[:password]
    render plain: User.check_crendentials(email, password)
  end
end
