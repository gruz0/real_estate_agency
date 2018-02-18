class CompetitorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to competitors_path, alert: t('views.competitor.flash_messages.competitor_was_not_found')
  end

  before_action :set_competitor, only: %i[show edit update destroy]

  include PeopleHelper

  def index
    @competitors = Competitor.page(params[:page])
  end

  def show; end

  def new
    @competitor = Competitor.new
  end

  def edit; end

  def create
    super(Competitor.new(competitor_params), t('views.competitor.flash_messages.competitor_was_successfully_created'))
  end

  def update
    super(@competitor, competitor_params, t('views.competitor.flash_messages.competitor_was_successfully_updated'))
  end

  def destroy
    super(@competitor, competitors_url, t('views.competitor.flash_messages.competitor_was_successfully_destroyed'))
  end

  private

  def set_competitor
    @competitor = Competitor.find(params[:id])
  end

  def competitor_params
    params.require(:competitor).permit(:name, :phone_numbers)
  end
end
