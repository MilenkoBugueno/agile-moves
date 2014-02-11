class InterruptionsController < ApplicationController
  # GET /interruptions
  # GET /interruptions.json
  def index
    @interruptions = Interruption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @interruptions }
    end
  end

  # GET /interruptions/1
  # GET /interruptions/1.json
  def show
    @interruption = Interruption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @interruption }
    end
  end

  # GET /interruptions/new
  # GET /interruptions/new.json
  def new
    @interruption = Interruption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @interruption }
    end
  end

  # GET /interruptions/1/edit
  def edit
    @interruption = Interruption.find(params[:id])
  end

  # POST /interruptions
  # POST /interruptions.json
  def create
    @interruption = Interruption.new(params[:interruption])

    respond_to do |format|
      if @interruption.save
        format.html { redirect_to @interruption, notice: 'Interruption was successfully created.' }
        format.json { render json: @interruption, status: :created, location: @interruption }
      else
        format.html { render action: "new" }
        format.json { render json: @interruption.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /interruptions/1
  # PUT /interruptions/1.json
  def update
    @interruption = Interruption.find(params[:id])

    respond_to do |format|
      if @interruption.update_attributes(params[:interruption])
        format.html { redirect_to @interruption, notice: 'Interruption was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @interruption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interruptions/1
  # DELETE /interruptions/1.json
  def destroy
    @interruption = Interruption.find(params[:id])
    @interruption.destroy

    respond_to do |format|
      format.html { redirect_to interruptions_url }
      format.json { head :no_content }
    end
  end
end
