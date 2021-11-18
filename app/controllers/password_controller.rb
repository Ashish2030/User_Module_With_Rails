class PasswordController < ApplicationController
  before_action :admin_user
  def admin_user
    if session[:user_id]!=nil
      flash[:success] = "Admin Access Granted"
    else
      flash[:success] = "first login"
      redirect_to account_login_path
    end
  end
  def forget_password
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user
        new_password = random_password
        logger.info new_password
        @user.update(:password=>new_password)
        UserNotifierMailer.random_password_send(@user,new_password).deliver
        flash[:notice] = "A new password has been sent your email"
        redirect_to "/account/login"
      else
        flash[:notice]="Invalid Email.Please enter correct email"
        render :action=>"forget_password"
      end
    end
  end

  def random_password
    (0...8).map{65.+(rand(25)).chr}.join
  end

  def reset_password
    if request.post?
      @user = User.find(session[:user_id])
      if @user
        @user.update(:password=>params[:password])
        UserNotifierMailer.reset_password_confirmation(@user).deliver
        puts '-------------resetting the password----------------'
        puts '-----------------------end-------------------------'
        flash[:notice] = "Your password has been reset"
        redirect_to :controller=>:account, :action=>:login
      else
        render :action=>:reset
      end
    end
  end
end
