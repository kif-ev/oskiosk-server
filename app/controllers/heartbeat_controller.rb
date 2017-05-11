class HeartbeatController < ApplicationController
  def check
    ActiveRecord::Base.connection.execute("SELECT 1;")
    expires_now # don't cache, don't generate e-tag
    render :plain => "ALIVE", :status => 200
  rescue Exception
    render :plain => "ERROR",  :status => 500
  end
end

