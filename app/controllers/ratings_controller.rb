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
    @move = Move.find(params[:move_id])
    @rating = @move.ratings.create!(params[:rating])
    
    if params[:thumb_rating] == "Approve"
      @rating.thumb_rating = 1;
    elsif params[:thumb_rating] == "Reject"
      @rating.thumb_rating = 0;
    end
    
    if params[:star_rating] == "Reject"
      @rating.star_rating = 0;
    end
    
    @rating.user_id = current_user.id
    
    respond_to do |format|
      if @rating.save
        format.html { redirect_to @move, notice: 'Rating was successfully created.' }
        format.json { render json: @move, status: :created, location: @move }
      else
        format.html { render action: "new" }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ratings/1
  # PUT /ratings/1.json
  def update
    @rating = Rating.find(params[:id])
    @move = Move.find(@rating.move_id)
    
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
    @move = Move.find(@rating.move_id)
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to @move }
      format.json { head :no_content }
    end
  end
end
