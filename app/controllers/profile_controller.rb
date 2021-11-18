class ProfileController < ApplicationController
  def edit_profile
    @user=User.find(session[:user_id]);
    if request.patch?
      logger.info "-------------------------------------------"
      if @user.update(article_params)
        logger.info "########################################"
        redirect_to "/home/index"
      else
        render "profile/edit_profile"
      end
    end
  end
  private
  def article_params
    params.require(:user).permit(:first_name,:last_name,:date_of_birth,:mobile,:email,:image)
  end
  end

