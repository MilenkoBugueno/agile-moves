class TomatoesController < ApplicationController
  # GET /tomatoes
  # GET /tomatoes.json
  def index
    @tomatoes = Tomato.order('state DESC')
    @tomatoes = @tomatoes.by_user_id(params[:user]) if params[:user].present?
    @tomatoes = @tomatoes.by_date(params[:date]) if params[:date].present?
    
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    @user = params[:user] ? params[:user] : current_user.id
    
    @users = User.all
    
    @states = State.order(:position)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tomatoes }
    end
  end

  # GET /tomatoes/1
  # GET /tomatoes/1.json
  def show
    @tomato = Tomato.find(params[:id])
    #@move_type = @tomato.move.move_type if @tomato.move.present?
    project_id =nil

    if @tomato.move.present?
      project_id = @tomato.move.project_id
    elsif @tomato.project_id.present?
      project_id = @tomato.project_id
    end
    @project = Project.find(project_id) if project_id.present?

    if @tomato.move.present?
      @move_type = @tomato.move.move_type
    else
      @move_type = @project.move_types.has_widget_type(0).first
    end

    # Custom Query for Comments as Nested Set Tree
    @comments = Comment.find_by_sql(["SELECT n.content, n.user_id, n.created_at, n.tomato_id, n.lft, n.rgt, n.move_id, n.id, p.tomato_id, COUNT(*)-1 AS level FROM comments AS n, comments AS p WHERE (n.tomato_id = p.tomato_id) AND (n.tomato_id = ?) AND (n.lft BETWEEN p.lft AND p.rgt) GROUP BY n.lft ORDER BY n.lft;", @tomato.id])



    #@wp_categories = wp_getCategories("learningtocode.de", "teamtool", "teamtool01", "1")
    @wp_categories = Hash.new
    @wp_blogs = wp_getUsersBlogs("learningtocode.de", "teamtool", "teamtool01")
    @wp_blogs.each do |blog|
      @wp_categories[blog] = wp_getCategories(blog, "teamtool", "teamtool01", "1")
    end

    # Wordpress Veröffentlichung
    if params[:wppublish] == "true"
      content = "Fun Rating: #{@tomato.rating.star_rating}\n\nGoal Reached: #{@tomato.rating.thumb_rating}\n\nTomatenkommentar: #{@tomato.rating.body}"
      title = "#{@tomato.title} von #{@tomato.user.name} am #{@tomato.created_at.strftime("%d.%m.%Y")}"
      @param_blogs = Hash.new
      @param_blogs = wp_pre_publish(params[:publish_to])
      #@tomato.dfsdf
      @param_blogs.each do |blog, categories|
        wp_publish(blog.to_s, "teamtool", "teamtool01", content, title, categories)
      end
      flash[:notice] = "Blog article published"
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tomato }
    end
  end

  # GET /tomatoes/new
  # GET /tomatoes/new.json
  def new
    @tomato = Tomato.new
    @tomato.user_id = current_user.id
    @project = Project.find(params[:project_id]) if params[:project_id].present?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tomato }
    end
  end

  # GET /tomatoes/1/edit
  def edit
    @tomato = Tomato.find(params[:id])
    @project = Project.find(@tomato.project_id) if @tomato.project_id.present?
    @move_type = @tomato.move.move_type if @tomato.move.present?
  end

  # POST /tomatoes
  # POST /tomatoes.json
  def create
    @move = Move.find(params[:move_id]) if params[:move_id].present?
    if @move != nil
      user_id = params['tomato']['user_id']
      if user_id.kind_of?(Array)
        user_id.each do |user|
          params['tomato']['user_id'] = user
          @tomato = @move.tomatoes.create!(params[:tomato]) unless user.to_i <= 0
        end
      else
        @tomato = @move.tomatoes.create!(params[:tomato])
      end
    end

    if @tomato == nil
      @tomato = Tomato.new(params[:tomato])
    end
    
    respond_to do |format|
      if @tomato.save
        if @move.present?
          format.html { redirect_to @move, notice: 'Tomato was successfully created.' }
        else
          format.html { redirect_to plan_projects_path(:id => @tomato.project.id), notice: 'Tomato was successfully created.' }
        end

      else
        format.html { render action: "new" }
        format.json { render json: @tomato.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def done
    @move = Move.find(params[:move_id]) unless params[:move_id] == nil

    if params["commit"]=="mark as done"
      Tomato.update_all({state: 2, publish_date: Date.today}, {id: params[:tomatoes_ids]})
    elsif params["commit"]=="plan today"
      Tomato.update_all({state: 1, publish_date: Date.today}, {id: params[:tomatoes_ids]})
    elsif params["commit"]=="unplan"
      Tomato.update_all({state: 0, publish_date: nil}, {id: params[:tomatoes_ids]})
    end  
    
    if @move!= nil
      redirect_to @move
    else
      redirect_to tomatoes_path(:user => current_user.id, :date => Date.today)
    end
  end
  
  
  # PUT /tomatoes/1
  # PUT /tomatoes/1.json
  def update
    @tomato = Tomato.find(params[:id])

    # LiveTomato braucht den Status ebenfalls
    if LiveTomato.where(:tomato_id => @tomato.id).blank?
      # do nothing
    else
      @live_tomato = LiveTomato.where(tomato_id: @tomato.id)
      LiveTomato.update(@live_tomato, :status => '2')
    end
    log_admin("AdminLog: Tomato updated")
    respond_to do |format|
      if @tomato.update_attributes(params[:tomato])
        format.html { redirect_to @tomato, notice: 'Tomato was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tomato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tomatoes/1
  # DELETE /tomatoes/1.json
  def destroy
    @tomato = Tomato.find(params[:id])
    @move_type = @tomato.move.move_type
    @move = @tomato.move if @tomato.move.present?
    project_id = @tomato.move.project_id if @tomato.move.present?
    @tomato.destroy
    log_admin("AdminLog: Tomato destroyed")
    respond_to do |format|
      if @move.present?
        format.html { redirect_to @move }
        format.json { head :no_content }
      else
        format.html { redirect_to plan_projects_path(:id => @move.project.id), notice: 'Tomato was successfully deleted.' }
      end

    end
  end


  def sendto
    @move_type = MoveType.find(params[:move_type_id])
    @project = Project.find(params[:project_id])
    @publish_date = params[:publish_date]==""? nil : params[:publish_date]
    Tomato.update_all({publish_date: @publish_date}, {id: params[:tomato_ids]})
    redirect_to plan_projects_path(:id => @project.id, :move_type => @move_type.id)
  end


end
