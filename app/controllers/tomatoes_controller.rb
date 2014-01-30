class TomatoesController < ApplicationController
  # GET /tomatoes
  # GET /tomatoes.json
  def index
    @tomatoes = Tomato.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tomatoes }
    end
  end

  # GET /tomatoes/1
  # GET /tomatoes/1.json
  def show
    @tomato = Tomato.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tomato }
    end
  end

  # GET /tomatoes/new
  # GET /tomatoes/new.json
  def new
    @tomato = Tomato.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tomato }
    end
  end

  # GET /tomatoes/1/edit
  def edit
    @tomato = Tomato.find(params[:id])
  end

  # POST /tomatoes
  # POST /tomatoes.json
  def create
    @tomato = Tomato.new(params[:tomato])

    respond_to do |format|
      if @tomato.save
        format.html { redirect_to @tomato, notice: 'Tomato was successfully created.' }
        format.json { render json: @tomato, status: :created, location: @tomato }
      else
        format.html { render action: "new" }
        format.json { render json: @tomato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tomatoes/1
  # PUT /tomatoes/1.json
  def update
    @tomato = Tomato.find(params[:id])

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
    @tomato.destroy

    respond_to do |format|
      format.html { redirect_to tomatoes_url }
      format.json { head :no_content }
    end
  end
end
