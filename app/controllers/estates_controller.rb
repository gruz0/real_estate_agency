class EstatesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to estates_path, alert: t('views.estate.flash_messages.estate_was_not_found')
  end

  before_action :set_estate, only: %i[show edit update destroy delay cancel_delay]
  before_action :set_attributes!, only: %i[create update]

  include PeopleHelper

  def index
    @estates = FindEstates.new(Estate.order('updated_at DESC')).call(permitted_params)
  end

  def show; end

  def new
    @estate = Estate.new
  end

  def edit; end

  def create
    super(Estate.new(@attributes.merge!(created_by_employee: current_employee)),
          t('views.estate.flash_messages.estate_was_successfully_created'))
  end

  def update
    # FIXME: It should be extracted to EstateService#updateable?(current_employee)
    if current_employee.admin? || current_employee.service_admin? || @estate.updateable_by?(current_employee) || !responsible_employee_changed?
      return super(@estate, @attributes.merge!(updated_by_employee: current_employee),
            t('views.estate.flash_messages.estate_was_successfully_updated'))
    end

    redirect_to(edit_estate_path(@estate), alert: t('estates.update.you_can_not_change_responsible_employee'))
  end

  def responsible_employee_changed?
    !@estate.assigned_to?(@attributes[:responsible_employee])
  end

  def destroy
    super(@estate, estates_url, t('views.estate.flash_messages.estate_was_successfully_destroyed'))
  end

  def delay
    if @estate.delay(employee: current_employee, delayed_until: estate_params[:delayed_until])
      redirect_to @estate, notice: t('views.estate.flash_messages.estate_was_successfully_updated')
    else
      render :edit
    end
  end

  def cancel_delay
    if @estate.cancel_delay(employee: current_employee)
      redirect_to @estate, notice: t('views.estate.flash_messages.estate_was_successfully_updated')
    else
      render :edit
    end
  end

  private

  def set_estate
    @estate = Estate.find(params[:id])
  end

  def set_attributes!
    responsible_employee = Employee.find_by(id: estate_params[:responsible_employee])
    estate_type = EstateType.find_by(id: estate_params[:estate_type])
    estate_project = EstateProject.find_by(id: estate_params[:estate_project])
    estate_material = EstateMaterial.find_by(id: estate_params[:estate_material])

    city = City.find_by(id: estate_params[:city])
    street = Street.find_by(city: city, id: estate_params[:street])
    address = Address.find_or_create_by(street: street, building_number: estate_params[:building_number])

    @attributes = estate_params.to_h
    @attributes.except!(:city, :street, :building_number)
               .merge!(responsible_employee: responsible_employee, address: address,
                       estate_type: estate_type, estate_project: estate_project, estate_material: estate_material)
  end

  def estate_params
    params.require(:estate).permit(:client_full_name, :client_phone_numbers, :responsible_employee,
                                   :city, :street, :building_number, :apartment_number,
                                   :estate_type, :estate_project, :estate_material, :number_of_rooms,
                                   :floor, :number_of_floors, :total_square_meters, :kitchen_square_meters,
                                   :description, :status, :price, :delayed_until)
  end

  def permitted_params
    params.permit(:page, :id, :estate_city, :estate_street, :estate_building_number, :estate_project, :number_of_rooms,
                  :floor_from, :floor_to, :price_from, :price_to, :total_square_meters_from, :total_square_meters_to,
                  :client_phone_numbers, :responsible_employee, :delayed_until, :status)
  end
end
