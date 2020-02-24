# frozen_string_literal: true

class CitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to cities_path, alert: t('views.city.flash_messages.city_was_not_found')
  end

  before_action :set_city, only: %i[show edit update destroy]

  def index
    @cities = City.order('id DESC').page(params[:page])
  end

  def show; end

  def new
    @city = City.new
  end

  def edit; end

  def create
    super(City.new(city_params), t('views.city.flash_messages.city_was_successfully_created'))
  end

  def update
    super(@city, city_params, t('views.city.flash_messages.city_was_successfully_updated'))
  end

  def destroy
    super(@city, cities_url, t('views.city.flash_messages.city_was_successfully_destroyed'))
  end

  private

  def set_city
    @city = City.find(params[:id])
  end

  def city_params
    params.require(:city).permit(:name)
  end
end
