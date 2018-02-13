class EstateProjectsController < ApplicationController
  before_action :set_estate_project, only: %i[show edit update destroy]

  def index
    @estate_projects = EstateProject.page(params[:page])
  end

  def show; end

  def new
    @estate_project = EstateProject.new
  end

  def edit; end

  def create
    @estate_project = EstateProject.new(estate_project_params)

    respond_to do |format|
      if @estate_project.save
        format.html do
          redirect_to @estate_project,
                      notice: t('views.estate_project.flash_messages.estate_project_was_successfully_created')
        end
        format.json { render :show, status: :created, location: @estate_project }
      else
        format.html { render :new }
        format.json { render json: @estate_project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @estate_project.update(estate_project_params)
        format.html do
          redirect_to @estate_project,
                      notice: t('views.estate_project.flash_messages.estate_project_was_successfully_updated')
        end
        format.json { render :show, status: :ok, location: @estate_project }
      else
        format.html { render :edit }
        format.json { render json: @estate_project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @estate_project.destroy
    respond_to do |format|
      format.html do
        redirect_to estate_projects_url,
                    notice: t('views.estate_project.flash_messages.estate_project_was_successfully_destroyed')
      end
      format.json { head :no_content }
    end
  end

  private

  def set_estate_project
    @estate_project = EstateProject.find(params[:id])
  end

  def estate_project_params
    params.require(:estate_project).permit(:name)
  end
end
