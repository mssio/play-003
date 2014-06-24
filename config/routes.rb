Rails.application.routes.draw do
  root :to => "visitors#index"
  
  get 'about', to: 'visitors#about'
  
  get 'verified', to: 'visitors#verified'
  get 'not-registered', to: 'visitors#not_registered'
  get 'fb-login', to: 'visitors#fb_login'
  get 'fb-logout', to: 'visitors#fb_logout'
  get 'fb-callback', to: 'visitors#fb_callback'
end
