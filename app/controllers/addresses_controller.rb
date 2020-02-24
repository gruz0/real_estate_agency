# frozen_string_literal: true

class AddressesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to addresses_path, alert: t('views.address.flash_messages.address_was_not_found')
  end

  before_action :redirect_if_employee_is_not_service_admin
  before_action :set_address, only: %i[show destroy]

  def index
    @addresses = Address.with_estates.order('id DESC').page(params[:page])
  end

  def show; end

  def destroy
    super(@address, addresses_url, t('views.address.flash_messages.address_was_successfully_destroyed'))
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end
end
