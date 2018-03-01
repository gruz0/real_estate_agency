class EstateProjectsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to estate_projects_path, alert: t('views.estate_project.flash_messages.estate_project_was_not_found')
  end

  before_action :set_estate_project, only: %i[show edit update destroy]

  def index
    @estate_projects = EstateProject.order('id DESC').page(params[:page])
  end

  def show; end

  def new
    @estate_project = EstateProject.new
  end

  def edit; end

  def create
    super(EstateProject.new(estate_project_params),
          t('views.estate_project.flash_messages.estate_project_was_successfully_created'))
  end

  def update
    super(@estate_project, estate_project_params,
          t('views.estate_project.flash_messages.estate_project_was_successfully_updated'))
  end

  def destroy
    super(@estate_project, estate_projects_url,
          t('views.estate_project.flash_messages.estate_project_was_successfully_destroyed'))
  end

  private

  def set_estate_project
    @estate_project = EstateProject.find(params[:id])
  end

  def estate_project_params
    params.require(:estate_project).permit(:name)
  end
end
