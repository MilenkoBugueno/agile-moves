class ReportsController < ApplicationController
  def index
    @tomatoes = Tomato.order('state DESC')
    @tomatoes = @tomatoes.by_user_id(params[:user]) if params[:user].present?
    @tomatoes_by_date = @tomatoes.group_by(&:publish_date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    @user = params[:user] ? params[:user] : current_user.id
    
    @users = User.all
    
  end
end
