class StreetsController < ApplicationController
  before_action :set_city, only: %i[create update]
  before_action :set_street, only: %i[show edit update destroy]

  def index
    @streets = Street.all
  end

  def show; end

  def new
    @street = Street.new
  end

  def edit; end

  def create
    @street = Street.new(street_params.merge(city: @city))

    respond_to do |format|
      if @street.save
        format.html { redirect_to @street, notice: 'Street was successfully created.' }
        format.json { render :show, status: :created, location: @street }
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
        format.html { redirect_to @street, notice: 'Street was successfully updated.' }
        format.json { render :show, status: :ok, location: @street }
      else
        format.html { render :edit }
        format.json { render json: @street.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @street.destroy
    respond_to do |format|
      format.html { redirect_to streets_url, notice: 'Street was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_city
    @city = City.find(street_params[:city])
  end

  def set_street
    @street = Street.find(params[:id])
  end

  def street_params
    params.require(:street).permit(:city, :name)
  end
end
