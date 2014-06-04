class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter do
    if request.ssl? || Rails.env.production? 
      redirect_to :protocol => 'http://'
    end
  end	
end