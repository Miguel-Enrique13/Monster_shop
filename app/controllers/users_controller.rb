class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new

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
end
