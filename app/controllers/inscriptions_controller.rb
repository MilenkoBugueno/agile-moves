class InscriptionsController < ApplicationController
  # GET /inscriptions
  # GET /inscriptions.json
  def index
    @inscriptions = Inscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inscriptions }
    end
  end

  # GET /inscriptions/1
  # GET /inscriptions/1.json
  def show
    @inscription = Inscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inscription }
    end
  end

  # GET /inscriptions/new
  # GET /inscriptions/new.json
  def new
    @inscription = Inscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inscription }
    end
  end

  # GET /inscriptions/1/edit
  def edit
    @inscription = Inscription.find(params[:id])
  end

  # POST /inscriptions
  # POST /inscriptions.json
  def create
    @inscription = Inscription.new(params[:inscription])

    respond_to do |format|
      if @inscription.save
        format.html { redirect_to @inscription, notice: 'Inscription was successfully created.' }
        format.json { render json: @inscription, status: :created, location: @inscription }
      else
        format.html { render action: "new" }
        format.json { render json: @inscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inscriptions/1
  # PUT /inscriptions/1.json
  def update
    @inscription = Inscription.find(params[:id])

    respond_to do |format|
      if @inscription.update_attributes(params[:inscription])
        format.html { redirect_to @inscription, notice: 'Inscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inscriptions/1
  # DELETE /inscriptions/1.json
  def destroy
    @inscription = Inscription.find(params[:id])
    @inscription.destroy

    respond_to do |format|
      format.html { redirect_to inscriptions_url }
      format.json { head :no_content }
    end
  end
end
