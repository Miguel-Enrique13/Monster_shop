class UsersController < ApplicationController
  before_action :require_user, only: :index

  def index
    @user = User.find(@current_user.id)
  end

  def new

  end

  def edit
    @user = current_user
  end

  def edit_password

  end

  def update_password
    current_user.attributes = user_params
    if current_user.save
      flash[:success] = "Password has been updated"
      redirect_to '/profile'
    else
      flash[:notice] = "Error updating your password"
      redirect_to '/profile/edit'
    end
  end

  def update
    current_user.attributes = user_params
    if current_user.save
      flash[:success] = "Your information has been updated"
      redirect_to '/profile'
    else
      flash[:notice] = current_user.errors.full_messages.to_sentence
      redirect_to '/profile/edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'You have been registered and are now logged in!'
      redirect_to '/profile'
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      redirect_to '/register'
    end
  end

  private
  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def require_user
    render file: '/public/404' if (current_user == nil)
  end
end
