class RegistrationsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
  def index
    @registrations = Registration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @registration = Registration.find(params[:id])

    @project = Project.find(params[:project_id]) if params[:project_id].present?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    @registration = Registration.new

    @certification = Certification.find(params[:certification_id]) if params[:certification_id].present?
    @project = Project.find(params[:project_id]) if params[:project_id].present?


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(params[:registration])

    respond_to do |format|
      if @registration.save
        @project = Project.find(@registration.project_id) if @registration.project_id.present?
        message = 'Registration was successfully created.'
        if @project.present?
          format.html { redirect_to certificate_projects_path(:id => @project.id), notice: message}
        else
          format.html { redirect_to @registration.certification, notice: message }
        end

        format.json { render json: @registration, status: :created, location: @registration }
      else
        format.html { render action: "new" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /registrations/1
  # PUT /registrations/1.json
  def update
    @registration = Registration.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        @project = Project.find(@registration.project_id) if @registration.project_id.present?
        message = 'Registration was successfully updated.'
        if @project.present?
          format.html { redirect_to certificate_projects_path(:id => @project.id), notice: message}
        else
          format.html { redirect_to @registration.certification, notice: message }
        end

        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration = Registration.find(params[:id])
    @certification = @registration.certification
    if @registration.project.present?
      @project = @registration.project
    end
    @registration.destroy


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
