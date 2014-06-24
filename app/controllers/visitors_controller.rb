class VisitorsController < ApplicationController
  include FacebookHelper
  before_action :set_fb_user, except: [:fb_login, :fb_logout, :fb_callback, :about]
  before_action :check_friend, :check_name, only: [:verified]
  
  def about
    require 'github/markup'
    # filename to be converted to HTML
    filename = "#{Rails.root}/README.md"
    # Read file contents
    contents = File.read(filename)
    # Render it to HTML and mark it as safe to avoid auto escaping 
    @text = GitHub::Markup.render(filename,contents).html_safe
  end
  
  def index
    Rails.logger.info session[:access_token]
    redirect_to '/verified' unless @fb_user.blank?
  end
  
  def verified
    redirect_to '/' if @fb_user.blank?
    redirect_to '/not-registered' unless check_friend && check_name
  end
  
  def not_registered
    redirect_to '/' if @fb_user.blank?
    redirect_to '/verified' if check_friend && check_name
    @fb_owner_link = Rails.application.secrets.facebook_owner_link.to_s
  end
  
  def fb_login
    redirect_to oauth.url_for_oauth_code( permissions: "user_friends" )
  end
  
  def fb_logout
    access_token = nil
    redirect_to '/'
  end
  
  def fb_callback
    set_token oauth.get_access_token(params[:code])
    redirect_to '/'
  end
  
  private
    def set_fb_user
      @fb_user = fb_user
      @fb_user_friends = fb_user_friends
      unless @fb_user.blank?
        @fb_user_db = FacebookUser.find_by name: @fb_user['name']
        if @fb_user_db
          @fb_user_db.app_profile_id ||= @fb_user['id'];
          @fb_user_db.my_friend = check_friend
        else
          @fb_user_db = FacebookUser.new
          @fb_user_db.name = @fb_user['name']
          @fb_user_db.app_profile_id = @fb_user['id'];
          @fb_user_db.my_friend = check_friend
        end
        @fb_user_db.save()
        @fb_user_db.touch(:last_login)
      end
    end
  
    def check_friend
      my_friend = false
      @fb_user_friends.each do |friend|
        my_friend = friend["id"].to_s == Rails.application.secrets.facebook_owner_id.to_s
        break if my_friend
      end
      my_friend
    end
  
    def check_name
      friend_name_list = FacebookFriend.pluck(:name)
      friend_name_list.include?(@fb_user["name"].to_s)
    end
end
