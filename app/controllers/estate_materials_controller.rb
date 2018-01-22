class EstateMaterialsController < ApplicationController
  before_action :set_estate_material, only: %i[show edit update destroy]

  def index
    @estate_materials = EstateMaterial.all
  end

  def show; end

  def new
    @estate_material = EstateMaterial.new
  end

  def edit; end

  def create
    @estate_material = EstateMaterial.new(estate_material_params)

    respond_to do |format|
      if @estate_material.save
        format.html do
          redirect_to @estate_material,
                      notice: t('views.estate_material.flash_messages.estate_material_was_successfully_created')
        end
        format.json { render :show, status: :created, location: @estate_material }
      else
        format.html { render :new }
        format.json { render json: @estate_material.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @estate_material.update(estate_material_params)
        format.html do
          redirect_to @estate_material,
                      notice: t('views.estate_material.flash_messages.estate_material_was_successfully_updated')
        end
        format.json { render :show, status: :ok, location: @estate_material }
      else
        format.html { render :edit }
        format.json { render json: @estate_material.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @estate_material.destroy
    respond_to do |format|
      format.html do
        redirect_to estate_materials_url,
                    notice: t('views.estate_material.flash_messages.estate_material_was_successfully_destroyed')
      end
      format.json { head :no_content }
    end
  end

  private

  def set_estate_material
    @estate_material = EstateMaterial.find(params[:id])
  end

  def estate_material_params
    params.require(:estate_material).permit(:name)
  end
end
