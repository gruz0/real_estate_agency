class StreetsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    if @city
      redirect_to city_streets_path(@city), alert: t('views.street.flash_messages.street_was_not_found')
    else
      redirect_to cities_path, alert: t('views.city.flash_messages.city_was_not_found')
    end
  end

  before_action :set_city
  before_action :set_street, only: %i[show edit update destroy]

  def index
    @streets = @city.street.page(params[:page])
  end

  def show; end

  def new
    @street = Street.new
  end

  def edit; end

  def search
    render json: @city.street.ordered_by_name.select(:id, :name)
  end

  def create
    @street = Street.new(street_params.merge(city: @city))
    @entity = @street

    if @street.save
      redirect_to city_street_path(@city, @street),
                  notice: t('views.street.flash_messages.street_was_successfully_created')
    else
      render :new
    end
  end

  def update
    new_params = street_params
    new_params.delete(:city)

    if @street.update(new_params)
      redirect_to city_street_path(@city, @street),
                  notice: t('views.street.flash_messages.street_was_successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    if @street.destroy
      redirect_to city_streets_url(@city), notice: t('views.street.flash_messages.street_was_successfully_destroyed')
    else
      redirect_to city_streets_url(@city), alert: @street.errors.full_messages.join
    end
  end

  private

  def set_city
    @city = City.find(params[:city_id])
  end

  def set_street
    @street = @city.street.find(params[:id])
    @entity = @street
  end

  def street_params
    params.require(:street).permit(:name)
  end
end
