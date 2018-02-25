class EmployeesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to employees_path, alert: t('views.employee.flash_messages.employee_was_not_found')
  end

  before_action :redirect_if_employee_is_not_admin
  before_action :set_employee, only: %i[show edit update destroy]
  before_action :allow_without_password, only: [:update]

  include PeopleHelper

  def index
    @employees = Employee.page(params[:page])
  end

  def show; end

  def new
    @employee = Employee.new
  end

  def edit; end

  def create
    super(Employee.new(employee_params), t('views.employee.flash_messages.employee_was_successfully_created'))
  end

  def update
    super(@employee, employee_params, t('views.employee.flash_messages.employee_was_successfully_updated'))
  end

  def destroy
    super(@employee, employees_url, t('views.employee.flash_messages.employee_was_successfully_destroyed'))
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:email, :password, :password_confirmation,
                                     :first_name, :last_name, :middle_name, :phone_numbers, :role)
  end

  def allow_without_password
    return unless params[:employee][:password].blank? && params[:employee][:password_confirmation].blank?

    params[:employee].delete(:password)
    params[:employee].delete(:password_confirmation)
  end
end
