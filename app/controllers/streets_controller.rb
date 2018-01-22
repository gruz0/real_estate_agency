class StreetsController < ApplicationController
  before_action :set_city
  before_action :set_street, only: %i[show edit update destroy]

  def index; end

  def show; end

  def new
    @street = Street.new
  end

  def edit; end

  def create
    @street = Street.new(street_params.merge(city: @city))

    respond_to do |format|
      if @street.save
        format.html { redirect_to city_street_path(@city, @street), notice: 'Street was successfully created.' }
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
        format.html { redirect_to city_street_path(@city, @street), notice: 'Street was successfully updated.' }
        format.json { render :show, status: :ok, location: city_street_url(@city, @street) }
      else
        format.html { render :edit }
        format.json { render json: @street.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @street.destroy
    respond_to do |format|
      format.html { redirect_to city_streets_url(@city), notice: 'Street was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_city
    @city = City.find(params[:city_id])
  end

  def set_street
    @street = Street.find_by(city: @city, id: params[:id])
  end

  def street_params
    params.require(:street).permit(:name)
  end
end
