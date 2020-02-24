# frozen_string_literal: true

class EstateMaterialsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to estate_materials_path, alert: t('views.estate_material.flash_messages.estate_material_was_not_found')
  end

  before_action :set_estate_material, only: %i[show edit update destroy]

  def index
    @estate_materials = EstateMaterial.order('id DESC').page(params[:page])
  end

  def show; end

  def new
    @estate_material = EstateMaterial.new
  end

  def edit; end

  def create
    super(EstateMaterial.new(estate_material_params),
          t('views.estate_material.flash_messages.estate_material_was_successfully_created'))
  end

  def update
    super(@estate_material, estate_material_params,
          t('views.estate_material.flash_messages.estate_material_was_successfully_updated'))
  end

  def destroy
    super(@estate_material, estate_materials_url,
          t('views.estate_material.flash_messages.estate_material_was_successfully_destroyed'))
  end

  private

  def set_estate_material
    @estate_material = EstateMaterial.find(params[:id])
  end

  def estate_material_params
    params.require(:estate_material).permit(:name)
  end
end
