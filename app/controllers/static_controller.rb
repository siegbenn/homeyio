class StaticController < ApplicationController
  def index
  	if user_signed_in?
    	redirect_to :controller=>'homes', :action => 'index'
  	end
  end

  def about
  end

  def pricing
  end
end
