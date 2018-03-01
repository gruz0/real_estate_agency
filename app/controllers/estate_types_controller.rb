class EstateTypesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to estate_types_path, alert: t('views.estate_type.flash_messages.estate_type_was_not_found')
  end

  before_action :set_estate_type, only: %i[show edit update destroy]

  def index
    @estate_types = EstateType.order('id DESC').page(params[:page])
  end

  def show; end

  def new
    @estate_type = EstateType.new
  end

  def edit; end

  def create
    super(EstateType.new(estate_type_params),
          t('views.estate_type.flash_messages.estate_type_was_successfully_created'))
  end

  def update
    super(@estate_type, estate_type_params, t('views.estate_type.flash_messages.estate_type_was_successfully_updated'))
  end

  def destroy
    super(@estate_type, estate_types_url, t('views.estate_type.flash_messages.estate_type_was_successfully_destroyed'))
  end

  private

  def set_estate_type
    @estate_type = EstateType.find(params[:id])
  end

  def estate_type_params
    params.require(:estate_type).permit(:name)
  end
end
