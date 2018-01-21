class EstateTypesController < ApplicationController
  before_action :set_estate_type, only: %i[show edit update destroy]

  def index
    @estate_types = EstateType.all
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
        format.html { redirect_to @estate_type, notice: 'Estate type was successfully created.' }
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
        format.html { redirect_to @estate_type, notice: 'Estate type was successfully updated.' }
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
      format.html { redirect_to estate_types_url, notice: 'Estate type was successfully destroyed.' }
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
