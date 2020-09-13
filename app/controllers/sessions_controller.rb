class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    
    if user.nil? || !user.authenticate(params[:password])
      flash[:notice] = 'Incorrect Password or Email'
      redirect_to '/login'
    else
      flash[:success] = 'You have been logged in'
      session[:user_id] = user.id
      redirect_to '/profile' if user.default?
      redirect_to '/merchant/dashboard' if user.merchant?
      redirect_to '/admin/dashboard' if user.admin?
    end

  end
end
