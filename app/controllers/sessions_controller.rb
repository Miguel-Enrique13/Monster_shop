class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = 'You have been logged in'
    redirect_to '/profile' if user.default?
    redirect_to '/merchant/dashboard' if user.merchant?
    redirect_to '/admin/dashboard' if user.admin?
  end
end
