class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  # GET /projects
  # GET /projects.json

  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  def work
    if params[:id].present?
      @project = Project.find(params[:id])
    else
      @project = Project.all.first
    end

    @user = params[:user] ? params[:user] : current_user.id

    @moves = Move.order('created_at DESC')
    @moves = @moves.by_user_ids(@user)
    @moves = @moves.by_project_id(@project.id) if params[:id].present?
    @moves = @moves.not_closed

    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    @move_types = MoveType.order('created_at DESC')
    @move_type_id = params[:move_type] ? params[:move_type] : @project.move_types.first
    @move_type = MoveType.find(@move_type_id) unless @move_type_id == nil
    @moves = @moves.by_move_type(@move_type_id) unless @move_type_id == nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end
  
  def report
    if params[:id].present?
      @project = Project.find(params[:id])
    else
      @project = Project.all.first
    end
    
    @tomatoes = Tomato.order('state DESC')
    @tomatoes = @tomatoes.by_user_id(params[:user]) if params[:user].present?
    @tomatoes = @tomatoes.by_project_id(params[:id]) if params[:id].present?
    @tomatoes_by_date = @tomatoes.group_by(&:publish_date)
    
    @moves = Move.order('created_at DESC')
    @moves = @moves.by_project_id(@project.id) if params[:id].present?

    @move_types = MoveType.order('created_at DESC')
    @move_type_id = params[:move_type] ? params[:move_type] : @project.move_types.first
    @move_type = MoveType.find(@move_type_id) unless @move_type_id == nil
    @moves = @moves.by_move_type(@move_type_id) unless @move_type_id == nil

    @moves = @moves.by_star_rating().sort{|a,b| b.stars <=> a.stars} if @move_type!= nil && @move_type.star_rating

    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    @user = params[:user] ? params[:user] : current_user.id
    
    @users = User.all
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id]) if params[:id].present?
    
    @move_types = MoveType.order('created_at DESC')
    @move_type_id = params[:move_type] ? params[:move_type] : @project.move_types.first
    @move_type = MoveType.find(@move_type_id) unless @move_type_id == nil

    @states = State.where(project_id: @project.id).order(:position)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id]) unless @project != nil

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id]) if params[:id].present?
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
