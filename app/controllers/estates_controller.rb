class EstatesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to estates_path, alert: t('views.estate.flash_messages.estate_was_not_found')
  end

  before_action :set_estate, only: %i[show edit update destroy]
  before_action :set_attributes!, only: %i[create update]

  include PeopleHelper

  def index
    @estates = FindEstates.new(Estate.all).call(permitted_params)
  end

  def show; end

  def new
    @estate = Estate.new
  end

  def edit; end

  def create
    @estate = Estate.new(@attributes.merge!(created_by_employee: current_employee))

    respond_to do |format|
      if @estate.save
        format.html do
          redirect_to @estate,
                      notice: t('views.estate.flash_messages.estate_was_successfully_created')
        end
        format.json { render :show, status: :created, location: @estate }
      else
        format.html { render :new }
        format.json { render json: @estate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @estate.update(@attributes.merge!(updated_by_employee: current_employee))
        format.html do
          redirect_to @estate,
                      notice: t('views.estate.flash_messages.estate_was_successfully_updated')
        end
        format.json { render :show, status: :ok, location: @estate }
      else
        format.html { render :edit }
        format.json { render json: @estate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @estate.destroy
    respond_to do |format|
      format.html do
        redirect_to estates_url,
                    notice: t('views.estate.flash_messages.estate_was_successfully_destroyed')
      end
      format.json { head :no_content }
    end
  end

  private

  def set_estate
    @estate = Estate.find(params[:id])
  end

  def set_attributes!
    client = Client.find_by(id: estate_params[:client])
    responsible_employee = Employee.find_by(id: estate_params[:responsible_employee])
    estate_type = EstateType.find_by(id: estate_params[:estate_type])
    estate_project = EstateProject.find_by(id: estate_params[:estate_project])
    estate_material = EstateMaterial.find_by(id: estate_params[:estate_material])

    city = City.find_by(id: estate_params[:city])
    street = Street.find_by(city: city, id: estate_params[:street])
    address = Address.find_or_create_by(street: street, building_number: estate_params[:building_number])

    @attributes = estate_params.to_h
    @attributes.except!(:city, :street, :building_number)
               .merge!(client: client, responsible_employee: responsible_employee, address: address,
                       estate_type: estate_type, estate_project: estate_project, estate_material: estate_material)
  end

  def estate_params
    params.require(:estate).permit(:client, :responsible_employee,
                                   :city, :street, :building_number, :apartment_number,
                                   :estate_type, :estate_project, :estate_material, :number_of_rooms,
                                   :floor, :number_of_floors, :total_square_meters, :kitchen_square_meters,
                                   :description, :status, :price)
  end

  def permitted_params
    params.permit(:page, :id, :estate_project, :number_of_rooms, :floor, :price_to, :responsible_employee)
  end
end
