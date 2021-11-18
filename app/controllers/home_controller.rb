class HomeController < ApplicationController

  before_action :admin_user
  def admin_user
    if session[:user_id]!=nil
      flash[:success] = "Admin Access Granted"
    else
      flash[:success] = "first login"
      redirect_to account_login_path
    end
  end
  def index
    @user = User.find(session[:user_id])
  end
end
