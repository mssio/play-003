module FacebookHelper
  def oauth
    @oauth ||= Koala::Facebook::OAuth.new(
      Rails.application.secrets.facebook_app_id,
      Rails.application.secrets.facebook_app_secret,
      "#{request.base_url}/fb-callback"
    )
  end
  
  def graph
    @graph ||= access_token.blank? ? false : Koala::Facebook::API.new(
      access_token,
      Rails.application.secrets.facebook_app_secret
    )
  end
  
  def graph=(set_graph)
    @graph = set_graph
  end
  
  def fb_user
    graph.blank? ? false : graph.get_object("me")
  end
  
  def fb_user_friends
    graph.blank? ? false : graph.get_connections("me","friends")
  end
  
  def set_token(token)
    self.access_token = token
  end
  
  def access_token=(set_token)
    session[:access_token] = set_token
    @access_token = set_token
  end
  
  def access_token
    @access_token ||= session[:access_token]
  end
end