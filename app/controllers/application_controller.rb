class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_instance_variable
  
  def set_instance_variable
    @hostname = request.base_url
  end
end
