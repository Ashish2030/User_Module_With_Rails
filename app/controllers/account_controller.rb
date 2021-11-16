class AccountController < ApplicationController
  def forget
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user
        new_password = random_password
        @user.update(:password=>new_password)
        UserNotifierMailer.random_password_send(@user,new_password).deliver
        flash[:notice] = "A new password has been sent your email"
        redirect_to :action=>"login"
      else
        flash[:notice]="Invalid Email.Please enter correct email"
        render :action=>"forget_password"
      end
      end
  end
  def signup
    if request.post?
      puts "--------------"
      @user=User.new(user_params)
      puts "--------------"
      if @user.save
        UserNotifierMailer.mailer(@user).deliver
        redirect_to :action => :login
      else
        render :action => :signup
      end
    end
  end

  def login
    if request.post?
      @user=User.find_by_email(params[:email])
        if @user.authenticate(params[:email],params[:password])
          session[:user_id]=@user.id;
          redirect_to "/home/index"
        else
          render :login
        end

      end
  end


  def random_password
    (0...8).map{65.+(rand(25)).chr}.join

  end


  private
  def user_params
    params.permit(:first_name,:last_name,:date_of_birth,:mobile,:email,:password,:hashed_password)
  end
end
