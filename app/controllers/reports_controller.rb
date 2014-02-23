class ReportsController < ApplicationController
  def index
    @tomatoes = Tomato.all
    @tomatoes_by_date = @tomatoes.group_by(&:publish_date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
