class RatingsController < ApplicationController
  before_filter :authenticate_user!
  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = Rating.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ratings }
    end
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
    @rating = Rating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rating }
    end
  end

  # GET /ratings/new
  # GET /ratings/new.json
  def new
    @rating = Rating.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rating }
    end
  end

  # GET /ratings/1/edit
  def edit
    @rating = Rating.find(params[:id])
  end

  # POST /ratings
  # POST /ratings.json
  def create
    if params[:move_id].present?
      @move = Move.find(params[:move_id])
      @move_type = @move.move_type
      @rating = @move.ratings.create!(params[:rating])
    elsif params[:tomato_id].present?
      @tomato = Tomato.find(params[:tomato_id])
      @move = @tomato.move
      @move_type = @move.move_type if @move.present?
      @rating = Rating.new(params[:rating])

      if LiveTomato.where(:tomato_id => @tomato.id).blank?
        # do nothing
      else
        @live_tomato = LiveTomato.where(tomato_id: @tomato.id)
        LiveTomato.update(@live_tomato, :star_rating => @rating.star_rating, :thumb_rating => @rating.thumb_rating)
      end
    end
    
    if params[:reject_star_rating].present?
      @rating.star_rating = 0
    end

    if params[:reject_thumb_rating].present?
      @rating.thumb_rating = 0
    end

    if params[:approve_thumb_rating].present?
      @rating.thumb_rating = 1
    end

    if params[:skip_star_rating].present?
      @rating.star_rating = -2
      @rating.thumb_rating = -2
    end

    respond_to do |format|
      if @rating.save
        if params[:skip_star_rating].present? && @move.project_id.present?
          @project = Project.find(@move.project_id)
          format.html { redirect_to work_projects_path(:id => @project.id, :move_type => @move_type.id), notice: 'Move was successfully skipped.' }
          format.json { head :no_content }
        elsif @move.present?
          format.html { redirect_to @move, notice: 'Rating was successfully created.' }
          format.json { render json: @move, status: :created, location: @move }
        elsif @tomato.move.present?
          format.html { redirect_to @tomato.move, notice: 'Rating was successfully created.' }
          format.json { render json: @tomato.move, status: :created, location: @tomato }
        else
          format.html { render action: "new" }
          format.json { render json: @move.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /ratings/1
  # PUT /ratings/1.json
  def update
    @rating = Rating.find(params[:id])
    if @rating.move_id != nil
      @move = @rating.move
    elsif @rating.tomato_id != nil
      @move = @rating.tomato.move
    end
    log_admin("AdminLog: Rating updated")
    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to @move, notice: 'Rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating = Rating.find(params[:id])
    if @rating.move_id != nil
      @move = @rating.move
    elsif @rating.tomato_id != nil
      @move = @rating.tomato
    end
    @rating.destroy
    log_admin("AdminLog: Rating destroyed")
    respond_to do |format|
      format.html { redirect_to @move }
      format.json { head :no_content }
    end
  end
end
