class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :soundcloud_client

  def soundcloud_client
  	@client = Soundcloud.new(:client_id => ENV["SOUNDCLOUD_CLIENT_ID"])
  end

end
