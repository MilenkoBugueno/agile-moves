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

  def plan
    if params[:id].present?
      @project = Project.find(params[:id])
    else
      @project = Project.all.first
    end

    @tomatoes = Tomato.order('publish_date ASC')
    @tomatoes = @tomatoes.by_project_id(@project.id)
    @tomatoes = @tomatoes.by_user_id(current_user.id)

    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @move_type = MoveType.find_by_make_my_sprint(true)

    @actual_sprint = Move.where("user_id=? AND move_type_id=? AND start_date <= ? AND publish_date >= ?", current_user.id, @move_type.id, Date.today(), Date.today()).first if @move_type.make_my_sprint

    if @actual_sprint.present?
      @todo_today_tomatoes = @tomatoes.where("publish_date = ?", Date.today)
      @activity_inventory_tomatoes = @tomatoes.where("publish_date > ? OR publish_date IS NULL", @actual_sprint.publish_date)
      @actual_sprint_tomatoes = @tomatoes.where("publish_date <= ? AND publish_date >= ? AND publish_date != ? ", @actual_sprint.publish_date, @actual_sprint.start_date, Date.today)
    else
      @todo_today_tomatoes = @tomatoes.where("publish_date = ?", Date.today)
      @activity_inventory_tomatoes = @tomatoes.where("publish_date > ? OR publish_date IS NULL", Date.today())
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def work
    if params[:id].present?
      @project = Project.find(params[:id])
    else
      @project = Project.all.first
    end

    @user = params[:user] ? params[:user] : current_user.id

    @moves = Move.order('publish_date ASC')
    @moves = @moves.by_user_ids(@user)
    @moves = @moves.by_project_id(@project.id) if params[:id].present?
    @moves = @moves.not_closed

    @date = params[:date] ? Date.parse(params[:date]) : Date.today


    @move_type = MoveType.find(params[:move_type]) if params[:move_type].present?
    if @move_type == nil || !@move_type.has_view(1)
      @move_type = @project.move_types.has_widget_type(1).first
    end
    @moves = @moves.by_move_type(@move_type.id) unless @move_type.id == nil

    @review_moves = Move.order('publish_date ASC').by_project_id(@project.id) if params[:id].present?
    @review_moves = @review_moves.nominated() if @review_moves.present?
    #@review_moves = @review_moves.by_reviewer(current_user.id)


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

    @moves = Move.order('publish_date ASC')
    @moves = @moves.by_user_id(params[:user] ) if params[:user].present?
    @moves = @moves.by_project_id(@project.id) if params[:id].present?

    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @move_type = MoveType.find(params[:move_type]) if params[:move_type].present?
    if @move_type == nil || !@move_type.has_view(2)
      @move_type = @project.move_types.has_widget_type(2).first
    end
    @moves = @moves.by_move_type(@move_type.id) unless @move_type.id == nil
    @moves_by_date = @moves.group_by(&:publish_date)


    @tomatoes = Tomato.order('created_at DESC')
    @tomatoes = @tomatoes.by_user_id(params[:user] ) if params[:user].present?
    @tomatoes = @tomatoes.by_project_id(@project.id) if params[:id].present?

    @tomatoes_by_date = @tomatoes.group_by(&:publish_date)

    #@moves = @moves.by_star_rating().sort{|a,b| b.stars <=> a.stars} if @move_type!= nil && @move_type.star_rating

    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    @user = params[:user] ? params[:user] : current_user.id
    
    @users = User.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def certificate
    @certifications = Certification.all

    user_id = params[:user] ? params[:user] : current_user.id
    @user = User.find(user_id)

    if params[:id].present?
      @project = Project.find(params[:id])
    else
      @project = Project.all.first
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id]) if params[:id].present?
    
    @move_types = MoveType.order('created_at DESC')
    move_type_id = params[:move_type] ? params[:move_type] : @project.move_types.first
    @move_type = MoveType.find(move_type_id) unless move_type_id == nil

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
    log_admin("AdminLog: Project updated")
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
    log_admin("AdminLog: Projekt destroyed")
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
