class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :soundcloud_client, :gon_variable

  include SessionsHelper

  def soundcloud_client
  	@client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
  end

  def gon_variable
    gon.client_id = ENV['SOUNDCLOUD_CLIENT_ID']
    gon.cloud_made_api_key = ENV['ClOUD_MADE_API_KEY']
  end

end
