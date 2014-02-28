class CapacitiesController < ApplicationController
  # GET /capacities
  # GET /capacities.json
  def index
    @capacities = Capacity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @capacities }
    end
  end

  # GET /capacities/1
  # GET /capacities/1.json
  def show
    @capacity = Capacity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @capacity }
    end
  end

  # GET /capacities/new
  # GET /capacities/new.json
  def new
    @capacity = Capacity.new

    respond_to do |format|
      #format.html # new.html.erb
      format.js {render :layout=>false}
      format.json { render json: @capacity }
    end
  end

  # GET /capacities/1/edit
  def edit
    @capacity = Capacity.find(params[:id])
  end

  # POST /capacities
  # POST /capacities.json
  def create
    @capacity = Capacity.new(params[:capacity])
    @capacity.user_id = current_user.id
    @capacity.publish_date = Date.today() unless @capacity.publish_date != nil
    

    respond_to do |format|
      if @capacity.save
        format.html { redirect_to @capacity, notice: 'Capacity was successfully created.' }
        format.json { render json: @capacity, status: :created, location: @capacity }
      else
        format.html { render action: "new" }
        format.json { render json: @capacity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /capacities/1
  # PUT /capacities/1.json
  def update
    @capacity = Capacity.find(params[:id])

    respond_to do |format|
      if @capacity.update_attributes(params[:capacity])
        format.html { redirect_to @capacity, notice: 'Capacity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @capacity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /capacities/1
  # DELETE /capacities/1.json
  def destroy
    @capacity = Capacity.find(params[:id])
    @capacity.destroy

    respond_to do |format|
      format.html { redirect_to capacities_url }
      format.json { head :no_content }
    end
  end
end
