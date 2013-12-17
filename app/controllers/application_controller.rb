class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :soundcloud_client, :gonify

  include SessionsHelper

  def soundcloud_client
  	@client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
  end

  def gonify
    gon.client_id = ENV['SOUNDCLOUD_CLIENT_ID']
    gon.map_id = ENV['MAP_ID']
    gon.soundcloud_client = @client
    gon.current_user = current_user
  end



end
