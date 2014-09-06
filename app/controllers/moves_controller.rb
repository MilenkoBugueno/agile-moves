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

    if @move.tomatoes.present?
      @tomato_moves = @move.tomatoes
      @tomato = @tomato_moves.first
      # Custom Query for Comments as Nested Set Tree
      @comments = Comment.find_by_sql(["SELECT n.content, n.user_id, n.created_at, n.tomato_id, n.lft, n.rgt, n.move_id, n.id, p.tomato_id, COUNT(*)-1 AS level FROM comments AS n, comments AS p WHERE (n.tomato_id = p.tomato_id) AND (n.tomato_id = ?) AND (n.lft BETWEEN p.lft AND p.rgt) GROUP BY n.lft ORDER BY n.lft;", @tomato.id])
    else
      @comments = Comment.find_by_sql(["SELECT n.content, n.user_id, n.created_at, n.move_id, n.lft, n.rgt, n.id, p.move_id, COUNT(*)-1 AS level FROM comments AS n, comments AS p WHERE (n.move_id = p.move_id) AND (n.move_id = ?) AND (n.lft BETWEEN p.lft AND p.rgt) GROUP BY n.lft ORDER BY n.lft;", @move.id])
    end

    #@wp_categories = wp_getCategories("learningtocode.de", "teamtool", "teamtool01", "1")
    #@wp_categories = Hash.new
    #@wp_blogs = wp_getUsersBlogs("learningtocode.de", "teamtool", "teamtool01")
    #@wp_blogs.each do |blog|
    #  @wp_categories[blog] = wp_getCategories(blog, "teamtool", "teamtool01", "1")
    #end

    # Wordpress publishing
    if params[:wppublish] == "true"
      content = "Fun Rating: #{@tomato.rating.star_rating}\n\nGoal Reached: #{@tomato.rating.thumb_rating}\n\nTomatenkommentar: #{@tomato.rating.body}"
      title = "#{@tomato.title} von #{@tomato.user.name} am #{@tomato.created_at.strftime("%d.%m.%Y")}"
      @param_blogs = Hash.new
      @param_blogs = wp_pre_publish(params[:publish_to])
      @param_blogs.each do |blog, categories|
        wp_publish(blog.to_s, "teamtool", "teamtool01", content, title, categories)
      end
      flash[:notice] = "Blog article published"
    end

    @project = Project.find(@move.project_id) if @move.project_id.present?
    @move_type = @move.move_type

    @tomato_moves = Move.order('publish_date ASC')
    @tomato_moves = @tomato_moves.by_project_id(@project.id)
    @tomato_moves = @tomato_moves.by_user_id(@move.user.id)
    @tomato_moves = @tomato_moves.by_tomatoes_number(1)
    if @move.present? && @move.publish_date.present?
      if @move.move_type.present? && @move.move_type.is_user_story
        @tomato_moves = @move.sub_moves
      elsif @move.move_type.make_my_day
        @tomato_moves = @tomato_moves.where("publish_date = ?", @move.publish_date)
      elsif @move.move_type.make_my_sprint && @move.start_date.present?
        @tomato_moves = @tomato_moves.where("publish_date <= ? AND publish_date >= ?", @move.publish_date, @move.start_date)
      elsif @move.tomatoes.present? && @move.tomatoes.count == 1
        @tomato = @move.tomatoes.first
        @tomato_moves = []
        @sprint_move = @move.get_sprint()
        @todotoday_move = @move.get_todo_today()
      else
        @tomato_moves = []
      end

    end

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

    @my_certifications = Registration.where("user_id=?", current_user.id)

    @user_story = Move.find(params[:user_story_id]) if params[:user_story_id].present?
    @user_stories = Move.by_user_stories()

    @date = params[:date] if params[:date].present?

    @registrations = Registration.all

    @compositions = Medium.joins(:moves).where(:moves => {:user_id => current_user.id}).where(:state_id=> 1).order('title ASC')
        #Medium.by_move_ids([@move.id, @move.id])

    if @user_story.present? || @date.present?
      @move_type = MoveType.find_by_tomatoes_number(1)
    elsif params[:make_my_sprint].present?
      @move_type = MoveType.find_by_make_my_sprint(true)
    elsif params[:make_my_day].present?
      @move_type = MoveType.find_by_make_my_day(true)
    elsif params[:move_type].present?
      @move_type = MoveType.find(params[:move_type])
    else
      @move_type = MoveType.first
    end


    @state = State.find_by_title(params[:state]) if params[:state].present?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @move }
    end
  end

  # GET /moves/1/edit
  def edit
    @move = Move.find(params[:id])
    @move_type = @move.move_type
    @project = Project.find(@move.project_id) if @move.project_id.present?
    @user_stories = Move.by_user_stories()

    @my_certifications = Registration.where("user_id=?", @move.user.id)

  end

  # POST /moves
  # POST /moves.json
  def create
    tomatoes_number = params["txtTomatoNo"].to_i if params["txtTomatoNo"].present?

    if tomatoes_number <= 0
      tomatoes_number = 1
    elsif tomatoes_number >= 20
      tomatoes_number = 20
    end

    for i in 1..tomatoes_number
      @move = Move.new(params[:move])
      @move.save
    end

    @move_type = @move.move_type
    @project = Project.find(@move.project_id) if @move.project_id.present?

    @sprint_move = @move.get_sprint()
    @todotoday_move = @move.get_todo_today()

    respond_to do |format|
      if @move.save

        if tomatoes_number > 1
          message =  "#{tomatoes_number} Moves were successfully created."
        else
          message =  "Move was successfully created."
        end

        if @move.user_story_id.present?
          format.html { redirect_to move_path(@move.user_story_id), notice: message}
        elsif @move.tomatoes.present? && @todotoday_move.present?
          format.html { redirect_to @todotoday_move, notice: message}
        elsif @move.tomatoes.present? && @sprint_move.present?
          format.html { redirect_to @sprint_move, notice: message}
        else
          format.html { redirect_to work_projects_path(:id => @project.id, :move_type => @move_type.id), notice: message}
        end


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
    @move_type = @move.move_type
    @project = Project.find(@move.project_id) if @move.project_id.present?

    log_admin("AdminLog: Move updated")
    respond_to do |format|
      if @move.update_attributes(params[:move])
        format.html { redirect_to @move, notice: 'Move was successfully updated.' }
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
    @move_type = @move.move_type
    @project = Project.find(@move.project_id) if @move.project_id.present?
    @move.destroy
    log_admin("AdminLog: Move destroyed")
    respond_to do |format|
      format.html { redirect_to work_projects_path(:id => @project.id, :move_type => @move_type.id) }
      format.json { head :no_content }
    end
  end

end
