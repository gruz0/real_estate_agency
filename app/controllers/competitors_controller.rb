class CompetitorsController < ApplicationController
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
    @competitor = Competitor.new(competitor_params)

    respond_to do |format|
      if @competitor.save
        format.html do
          redirect_to @competitor, notice: t('views.competitor.flash_messages.competitor_was_successfully_created')
        end
        format.json { render :show, status: :created, location: @competitor }
      else
        format.html { render :new }
        format.json { render json: @competitor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @competitor.update(competitor_params)
        format.html do
          redirect_to @competitor, notice: t('views.competitor.flash_messages.competitor_was_successfully_updated')
        end
        format.json { render :show, status: :ok, location: @competitor }
      else
        format.html { render :edit }
        format.json { render json: @competitor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @competitor.destroy
    respond_to do |format|
      format.html do
        redirect_to competitors_url, notice: t('views.competitor.flash_messages.competitor_was_successfully_destroyed')
      end
      format.json { head :no_content }
    end
  end

  private

  def set_competitor
    @competitor = Competitor.find_by(id: params[:id])
  end

  def competitor_params
    params.require(:competitor).permit(:name, :phone_numbers)
  end
end
