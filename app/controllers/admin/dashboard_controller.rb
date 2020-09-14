class Admin::DashboardController < ApplicationController
  def index

  end

  def show_users
    @users = User.all
  end
end
