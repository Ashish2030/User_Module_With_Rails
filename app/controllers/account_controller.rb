class AccountController < ApplicationController
  def signup
    @user=User.new
    if request.post?
      logger.info("POST REQUEST")
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

  def logout
    session[:user_id]=nil;
    redirect_to :action => :login
  end


  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:date_of_birth,:mobile,:email,:password,:hashed_password,:image)
  end
end
