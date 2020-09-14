class Admin::DashboardController < Admin::BaseController

  def index

  end

  def show_users
    @users = User.all
  end
end
