class ReportsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @user = params[:user] ? params[:user] : current_user.id
  end
  def tomatoes
    @tomatoes = Tomato.order('state DESC')
    @tomatoes = @tomatoes.by_user_id(params[:user]) if params[:user].present?
    @tomatoes_by_date = @tomatoes.group_by(&:publish_date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    @user = params[:user] ? params[:user] : current_user.id
    
    @users = User.all
    
  end
  
  def ideas
    
    @moves = Move.order('created_at DESC')
    #@moves = @moves.by_user_ids(params[:user]) if params[:user].present?
    @moves = @moves.twitter_idea()
    
    @user = params[:user] ? params[:user] : current_user.id
    
    @move_types = MoveType.order('created_at DESC')
    @move_type = params[:move_type] if params[:move_type].present?
  end
end
