class MediaController < ApplicationController
  # GET /media
  # GET /media.json
  def index
    @media = Medium.order("title ASC")

    @media_current = @media.where("state_id=?", 1)
    @media_partial = @media.where("state_id=?", 2)
    @media_ready = @media.where("state_id=?", 3)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media }
    end
  end

  # GET /media/1
  # GET /media/1.json
  def show
    @medium = Medium.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medium }
    end
  end

  # GET /media/new
  # GET /media/new.json
  def new
    @medium = Medium.new
    @move = Move.find(params[:move_id]) if params[:move_id].present?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
    end
  end

  # GET /media/1/edit
  def edit
    @medium = Medium.find(params[:id])
  end

  # POST /media
  # POST /media.json
  def create
    @medium = Medium.new(params[:medium])

    respond_to do |format|
      if @medium.save
        if @medium.moves.present?
          format.html { redirect_to @medium.moves.first, notice: 'Medium was successfully created.' }
        else
          format.html { redirect_to @medium, notice: 'Medium was successfully created.' }
        end

        format.json { render json: @medium, status: :created, location: @medium }
      else
        format.html { render action: "new" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /media/1
  # PUT /media/1.json
  def update
    @medium = Medium.find(params[:id])

    respond_to do |format|
      if @medium.update_attributes(params[:medium])
        if @medium.moves.present?
          format.html { redirect_to @medium.moves.first, notice: 'Medium was successfully updated.' }
        else
          format.html { redirect_to @medium, notice: 'Medium was successfully updated.' }
        end

        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  # DELETE /media/1.json
  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy

    respond_to do |format|
      format.html { redirect_to media_url }
      format.json { head :no_content }
    end
  end

  def sendto
    if params["move_to_current"].present?
      state = 1
    elsif params["move_to_partial"].present?
      state = 2
    elsif params["move_to_ready"].present?
      state = 3
    else
      state = 1
    end

    params[:medium_ids].each do |medium_id|
      medium = Medium.find(medium_id)
      medium.update_attributes(state_id: state)
    end

     medium = Medium.find(params[:medium_ids].first) if params[:medium_ids].present?
    if medium.present? && medium.moves.present?
      redirect_to medium.moves.first
    else
      redirect_to media_url
    end

  end

end
