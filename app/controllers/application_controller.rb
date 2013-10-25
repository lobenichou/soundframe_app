class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :soundcloud_client

  def soundcloud_client
  	@client = Soundcloud.new(:client_id => '7bc71d1e26e8b1d2ee33dbd1dee5b8bd')
  end

end
