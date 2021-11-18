Rails.application.routes.draw do
  get 'home/index'
  get 'password/forget_password'
  post 'password/forget_password'
  get 'password/reset_password'
  post 'password/reset_password'
  get 'profile/edit_profile'
  patch 'profile/edit_profile'
  get 'account/signup'
  post 'account/signup'
  get 'account/login'
  post 'account/login'
  get 'account/logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
