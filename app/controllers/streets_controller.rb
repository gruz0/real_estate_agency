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

    respond_to do |format|
      if @street.save
        format.html do
          redirect_to city_street_path(@city, @street),
                      notice: t('views.street.flash_messages.street_was_successfully_created')
        end
        format.json { render :show, status: :created, location: city_street_url(@city, @street) }
      else
        format.html { render :new }
        format.json { render json: @street.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      new_params = street_params
      new_params.delete(:city)

      if @street.update(new_params)
        format.html do
          redirect_to city_street_path(@city, @street),
                      notice: t('views.street.flash_messages.street_was_successfully_updated')
        end
        format.json { render :show, status: :ok, location: city_street_url(@city, @street) }
      else
        format.html { render :edit }
        format.json { render json: @street.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @street.destroy
        format.html do
          redirect_to city_streets_url(@city),
                      notice: t('views.street.flash_messages.street_was_successfully_destroyed')
        end
        format.json { head :no_content }
      else
        format.html { redirect_to city_streets_url(@city), alert: @street.errors.full_messages.join }
        format.json { render json: @street.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_city
    @city = City.find(params[:city_id])
  end

  def set_street
    @street = @city.street.find(params[:id])
  end

  def street_params
    params.require(:street).permit(:name)
  end
end
