class AdminLogsController < ApplicationController
  def index

    if params[:filter] == "username"
      @adminlog = AdminLog.where('username = ?', params[:value])
      @filter = "username"
    elsif params[:filter] == "controller"
      @adminlog = AdminLog.where('controller = ?', params[:value])
      @filter = "controller"
    elsif params[:filter] == "action"
      @adminlog = AdminLog.where('action = ?', params[:value])
      @filter = "action"
    else
      @adminlog = AdminLog.order("created_at DESC")
      @filter = "none"
    end

    @adminlognames = AdminLog.uniq.pluck(:username)
    @adminlogcontroller = AdminLog.uniq.pluck(:controller)
    @adminlogaction = AdminLog.uniq.pluck(:action)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adminlog }
    end
  end
end