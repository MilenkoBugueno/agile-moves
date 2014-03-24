class MovesController < ApplicationController
  before_filter :authenticate_user!
  # GET /moves
  # GET /moves.json
  def index
    @moves = Move.order('created_at DESC')
    @moves = @moves.by_user_ids(params[:user]) if params[:user].present?
    @moves = @moves.by_move_type(params[:move_type]) if params[:move_type].present?
    
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    @user = params[:user] ? params[:user] : current_user.id
    
    @users = User.all
    
    @move_types = MoveType.order('created_at DESC')
    @move_type = params[:move_type] if params[:move_type].present?
    
    @states = State.order(:position)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @moves }
    end
  end

  # GET /moves/1
  # GET /moves/1.json
  def show
    @move = Move.find(params[:id])
    @ratings = Rating.where(:move_id => :id)
    @ratings = Tomato.where(:move_id => :id)
    
    @project = Project.find(@move.project_id) if @move.project_id.present?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @move }
    end
  end

  # GET /moves/new
  # GET /moves/new.json
  def new
    @move = Move.new
    @project = Project.find(params[:project_id]) if params[:project_id].present?
    @states = State.order(:position)
    @states = @states.where(project_id: params[:project_id]) if params[:project_id].present?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @move }
    end
  end

  # GET /moves/1/edit
  def edit
    @move = Move.find(params[:id])
    @project = Project.find(@move.project_id) if @move.project_id.present?
  end

  # POST /moves
  # POST /moves.json
  def create
    @move = Move.new(params[:move])
    @project = Project.find(@move.project_id) if @move.project_id.present?
    #@ratings = @move.ratings
    #@ratings.each do |rating|
    #  RailsthemesMailer.test_email_one_column(rating.user)
    #end

    respond_to do |format|
      if @move.save
        format.html { redirect_to plan_projects_path(:id => @project.id), notice: 'Move was successfully created.' }
        format.json { render json: @move, status: :created, location: @move }
      else
        format.html { render action: "new" }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /moves/1
  # PUT /moves/1.json
  def update
    @move = Move.find(params[:id])
    @project = Project.find(@move.project_id) if @move.project_id.present?

    respond_to do |format|
      if @move.update_attributes(params[:move])
        format.html { redirect_to plan_projects_path(:id => @project.id), notice: 'Move was successfully updatetd.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moves/1
  # DELETE /moves/1.json
  def destroy
    @move = Move.find(params[:id])
    @project = Project.find(@move.project_id) if @move.project_id.present?
    @move.destroy

    respond_to do |format|
      format.html { redirect_to plan_projects_path(:id => @project.id) }
      format.json { head :no_content }
    end
  end  
 
end
