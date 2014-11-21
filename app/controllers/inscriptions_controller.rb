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

    @project = Project.find(params[:project_id]) if params[:project_id].present?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inscription }
    end
  end

  # GET /inscriptions/new
  # GET /inscriptions/new.json
  def new
    @inscription = Inscription.new

    @certification = Certification.find(params[:certification_id]) if params[:certification_id].present?
    @project = Project.find(params[:project_id]) if params[:project_id].present?


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
        @project = Project.find(@inscription.project_id) if @inscription.project_id.present?
        message = 'Registration was successfully created.'
        if @project.present?
          format.html { redirect_to certificate_projects_path(:id => @project.id), notice: message}
        else
          format.html { redirect_to @inscription.certification, notice: message }
        end

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
        @project = Project.find(@inscription.project_id) if @inscription.project_id.present?
        message = 'Registration was successfully updated.'
        if @project.present?
          format.html { redirect_to certificate_projects_path(:id => @project.id), notice: message}
        else
          format.html { redirect_to @inscription.certification, notice: message }
        end
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
    @certification = @inscription.certification
    if @inscription.project.present?
      @project = @inscription.project
    end

    @inscription.destroy

    respond_to do |format|
      if @project.present?
        format.html { redirect_to certificate_projects_path(:id => @project.id)}
      else
        format.html { redirect_to @certification }
      end
      format.json { head :no_content }
    end
  end
end
