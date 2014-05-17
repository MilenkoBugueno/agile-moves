class MoveTypesController < ApplicationController
  # GET /move_types
  # GET /move_types.json
  def index
    @move_types = MoveType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @move_types }
    end
  end

  # GET /move_types/1
  # GET /move_types/1.json
  def show
    @move_type = MoveType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @move_type }
    end
  end

  # GET /move_types/new
  # GET /move_types/new.json
  def new
    @move_type = MoveType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @move_type }
    end
  end

  # GET /move_types/1/edit
  def edit
    @move_type = MoveType.find(params[:id])
  end

  # POST /move_types
  # POST /move_types.json
  def create
    @move_type = MoveType.new(params[:move_type])

    respond_to do |format|
      if @move_type.save
        format.html { redirect_to @move_type, notice: 'Move type was successfully created.' }
        format.json { render json: @move_type, status: :created, location: @move_type }
      else
        format.html { render action: "new" }
        format.json { render json: @move_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /move_types/1
  # PUT /move_types/1.json
  def update
    @move_type = MoveType.find(params[:id])
    log_admin("AdminLog: Move Type updated")
    respond_to do |format|
      if @move_type.update_attributes(params[:move_type])
        format.html { redirect_to @move_type, notice: 'Move type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @move_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /move_types/1
  # DELETE /move_types/1.json
  def destroy
    @move_type = MoveType.find(params[:id])
    @move_type.destroy
    log_admin("AdminLog: Move Type destroyed")
    respond_to do |format|
      format.html { redirect_to move_types_url }
      format.json { head :no_content }
    end
  end
end
