class EstateTypesController < ApplicationController
  before_action :set_estate_type, only: %i[show edit update destroy]

  def index
    @estate_types = EstateType.page(params[:page])
  end

  def show; end

  def new
    @estate_type = EstateType.new
  end

  def edit; end

  def create
    @estate_type = EstateType.new(estate_type_params)

    respond_to do |format|
      if @estate_type.save
        format.html do
          redirect_to @estate_type,
                      notice: t('views.estate_type.flash_messages.estate_type_was_successfully_created')
        end
        format.json { render :show, status: :created, location: @estate_type }
      else
        format.html { render :new }
        format.json { render json: @estate_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @estate_type.update(estate_type_params)
        format.html do
          redirect_to @estate_type,
                      notice: t('views.estate_type.flash_messages.estate_type_was_successfully_updated')
        end
        format.json { render :show, status: :ok, location: @estate_type }
      else
        format.html { render :edit }
        format.json { render json: @estate_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @estate_type.destroy
    respond_to do |format|
      format.html do
        redirect_to estate_types_url,
                    notice: t('views.estate_type.flash_messages.estate_type_was_successfully_destroyed')
      end
      format.json { head :no_content }
    end
  end

  private

  def set_estate_type
    @estate_type = EstateType.find(params[:id])
  end

  def estate_type_params
    params.require(:estate_type).permit(:name)
  end
end
