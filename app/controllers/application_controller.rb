class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :soundcloud_client, :gon_variable

  include SessionsHelper

  def soundcloud_client
  	@client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
  end

  def gon_variable
    gon.client_id = ENV['SOUNDCLOUD_CLIENT_ID']
    gon.map_id = ENV['MAP_ID']
    gon.soundcloud_client = @client
  end



end
