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
    @move_type = @tomato.move.move_type
    @project = Project.find(@tomato.move.project_id) if @tomato.move.project_id.present?

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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tomato }
    end
  end

  # GET /tomatoes/1/edit
  def edit
    @tomato = Tomato.find(params[:id])
    @project = Project.find(@tomato.move.project_id) if @tomato.move.project_id.present?
    @move_type = @tomato.move.move_type if @tomato.move.move_type.present?
  end

  # POST /tomatoes
  # POST /tomatoes.json
  def create
    @move = Move.find(params[:move_id])
    users = params['tomato']['user_id']
    users.each do |user|
      params['tomato']['user_id'] = user
      @tomato = @move.tomatoes.create!(params[:tomato]) unless user.to_i <= 0
    end
    
    if @tomato == nil
      @tomato = @move.tomatoes.create!(params[:tomato])
    end
    
    respond_to do |format|
      if @tomato.save
        format.html { redirect_to @move, notice: 'Tomato was successfully created.' }
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
    project_id = @tomato.move.project_id if @tomato.move.present?
    @tomato.destroy

    respond_to do |format|
      format.html { redirect_to work_projects_path(:id => project_id) }
      format.json { head :no_content }
    end
  end
  
  
end
