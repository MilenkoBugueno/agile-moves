class RatingsController < ApplicationController
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
      @container = Move.find(params[:move_id])
      @rating = @container.ratings.create!(params[:rating])
    elsif params[:tomato_id].present?
      @container = Tomato.find(params[:tomato_id])
      @rating = Rating.new(params[:rating])

      if LiveTomato.where(:tomato_id => @container.id).blank?
        # do nothing
      else
        @live_tomato = LiveTomato.where(tomato_id: @container.id)
        LiveTomato.update(@live_tomato, :star_rating => @rating.star_rating, :thumb_rating => @rating.thumb_rating)
      end
    end
    
    if params[:reject_star_rating].present?
      @rating.star_rating = 0
    end

    if params[:skip_star_rating].present?
      @rating.star_rating = -2
      @rating.thumb_rating = -2
    end

    respond_to do |format|
      if @rating.save
        if params[:skip_star_rating].present? && @container.project_id.present?
          @project = Project.find(@container.project_id)
          format.html { redirect_to work_projects_path(:id => @project.id), notice: 'Move was successfully skipped.' }
          format.json { head :no_content }
        else
          format.html { redirect_to @container, notice: 'Rating was successfully created.' }
          format.json { render json: @container, status: :created, location: @tomato }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ratings/1
  # PUT /ratings/1.json
  def update
    @rating = Rating.find(params[:id])
    if @rating.move_id != nil
      @container = @rating.move
    elsif @rating.tomato_id != nil
      @container = @rating.tomato
    end
    
    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to @container, notice: 'Rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating = Rating.find(params[:id])
    if @rating.move_id != nil
      @container = @rating.move
    elsif @rating.tomato_id != nil
      @container = @rating.tomato
    end
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to @container }
      format.json { head :no_content }
    end
  end
end
