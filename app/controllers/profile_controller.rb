class ProfileController < ApplicationController
  def edit_profile
    @user=User.find(session[:user_id]);
  end
end
