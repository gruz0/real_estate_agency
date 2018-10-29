class EstatesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to estates_path, alert: t('views.estate.flash_messages.estate_was_not_found')
  end

  before_action :set_estate, only: %i[show edit update destroy]
  before_action :set_attributes!, only: %i[create update]
  before_action :redirect_if_employee_does_not_have_access_to_updateable_estate, only: %i[update],
                                                                                 if: -> { current_employee.user? }

  include PeopleHelper

  def index
    @estates = FindEstates.new(Estate.order('id DESC')).call(permitted_params)
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
    super(@estate, @attributes.merge!(updated_by_employee: current_employee),
          t('views.estate.flash_messages.estate_was_successfully_updated'))
  end

  def destroy
    super(@estate, estates_url, t('views.estate.flash_messages.estate_was_successfully_destroyed'))
  end

  private

  def set_estate
    @estate = Estate.find(params[:id])
  end

  def redirect_if_employee_does_not_have_access_to_updateable_estate
    if @estate.created_by?(current_employee)
      if @estate.assigned_to?(current_employee)
        return if @attributes[:responsible_employee].eql?(current_employee)
      else
        return if @estate.assigned_to?(@attributes[:responsible_employee])
      end

      redirect_to(edit_estate_path(@estate), alert: t('estates.update.you_can_not_change_responsible_employee'))
    else
      if @estate.assigned_to?(current_employee)
        return if @attributes[:responsible_employee].eql?(current_employee)
        redirect_to(edit_estate_path(@estate), alert: t('estates.update.you_can_not_change_responsible_employee'))
      else
        if @attributes[:responsible_employee].eql?(@estate.responsible_employee)
          @attributes[:responsible_employee] = @estate.responsible_employee
        else
          redirect_to(edit_estate_path(@estate), alert: t('estates.update.you_can_not_change_responsible_employee'))
        end
      end
    end
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
                                   :description, :status, :price)
  end

  def permitted_params
    params.permit(:page, :id, :estate_city, :estate_street, :estate_building_number, :estate_project, :number_of_rooms,
                  :floor_from, :floor_to, :price_from, :price_to, :total_square_meters_from, :total_square_meters_to,
                  :client_phone_numbers, :responsible_employee)
  end
end
