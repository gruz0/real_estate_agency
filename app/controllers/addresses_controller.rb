class AddressesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    if @city
      if @street
        redirect_to city_street_addresses_path(@city, @street), alert: t('views.address.flash_messages.address_was_not_found')
      else
        redirect_to city_streets_path(@city), alert: t('views.street.flash_messages.street_was_not_found')
      end
    else
      redirect_to cities_path, alert: t('views.city.flash_messages.city_was_not_found')
    end
  end

  before_action :set_city
  before_action :set_street
  before_action :set_address, only: %i[show destroy]

  def index
    @addresses = @street.address.page(params[:page])
  end

  def show; end

  def destroy
    super(@address, city_street_addresses_url(@city, @street),
          t('views.address.flash_messages.address_was_successfully_destroyed'))
  end

  private

  def set_city
    @city = City.find(params[:city_id])
  end

  def set_street
    @street = @city.street.find(params[:street_id])
  end

  def set_address
    @address = @street.address.find(params[:id])
  end
end
