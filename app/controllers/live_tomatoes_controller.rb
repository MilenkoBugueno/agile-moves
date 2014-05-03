class LiveTomatoesController < ApplicationController
  # GET /live_tomatoes
  # GET /live_tomatoes.json
  def index
    # live tomato liste auf den aktuellen Tag beschränken
    gestern = 1.day.ago.strftime('%Y-%m-%d')
    LiveTomato.delete_all "created_at < '" + gestern.to_s + "'"

    @live_tomatoes = LiveTomato.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      #format.json { render json: @live_tomatoes }
    end
  end

  # GET /live_tomatoes/1
  # GET /live_tomatoes/1.json
  def show
    @live_tomato = LiveTomato.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @live_tomato }
    end
  end

  # GET /live_tomatoes/new
  # GET /live_tomatoes/new.json
  def new
    @live_tomato = LiveTomato.new

    if params['live'].to_i == 1
      @live_tomato.title = params['title']
      @live_tomato.starttime = params['starttime']
      @live_tomato.username = params['username']
      @live_tomato.userid = params['userid']
      @live_tomato.endtime = params['endtime']
      @live_tomato.currenttime = params['currenttime']
      @live_tomato.tomato_id = params['tomato_id']
      @live_tomato.status = 1
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @live_tomato }
    end
  end

  # GET /live_tomatoes/1/edit
  def edit
    @live_tomato = LiveTomato.find(params[:id])
  end

  # POST /live_tomatoes
  # POST /live_tomatoes.json
  def create

    @live_tomato = LiveTomato.new(params[:live_tomato])

    respond_to do |format|
      if @live_tomato.save
        #format.html { redirect_to @live_tomato, notice: 'Live tomato was successfully created.' }
        #format.html { redirect_to live_tomatoes_path }
        format.html { render :text => '<script type="text/javascript"> window.close() </script>' }
        format.json { render json: @live_tomato, status: :created, location: @live_tomato }
      else
        format.html { render action: "new" }
        format.json { render json: @live_tomato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /live_tomatoes/1
  # PUT /live_tomatoes/1.json
  def update
    @live_tomato = LiveTomato.find(params[:id])

    respond_to do |format|
      if @live_tomato.update_attributes(params[:live_tomato])
        format.html { redirect_to @live_tomato, notice: 'Live tomato was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @live_tomato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /live_tomatoes/1
  # DELETE /live_tomatoes/1.json
  def destroy
    @live_tomato = LiveTomato.find(params[:id])
    @live_tomato.destroy

    respond_to do |format|
      format.html { redirect_to live_tomatoes_url }
      format.json { head :no_content }
      format.js   { render :nothing => true }
    end
  end
end
