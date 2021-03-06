# frozen_string_literal: true

class EmployeesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to employees_path, alert: t('views.employee.flash_messages.employee_was_not_found')
  end

  before_action :redirect_if_employee_is_not_admin_or_service_admin
  before_action :redirect_if_admin_try_to_set_user_role_to_service_admin, only: %i[create update]
  before_action :set_employee, only: %i[show edit update lock unlock]
  before_action :redirect_if_admin_try_to_edit_service_admin, only: %i[edit update lock unlock]
  before_action :redirect_if_admin_or_service_admin_try_to_lock_himself, only: %i[lock]
  before_action :redirect_if_admin_or_service_admin_try_to_unlock_himself, only: %i[unlock]
  before_action :allow_without_password, only: [:update]

  include PeopleHelper

  def index
    @employees = Employee.order('id DESC').page(params[:page])
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

  def lock
    @employee.lock_access!
    redirect_to employees_url, notice: t('views.employee.flash_messages.employee_was_successfully_locked')
  end

  def unlock
    @employee.unlock_access!
    redirect_to employees_url, notice: t('views.employee.flash_messages.employee_was_successfully_unlocked')
  end

  private

  def redirect_if_admin_try_to_set_user_role_to_service_admin
    return if current_employee.service_admin?
    return unless employee_params[:role] == 'service_admin'

    redirect_to(root_path, alert: t('errors.messages.forbidden'))
  end

  def redirect_if_admin_try_to_edit_service_admin
    return if current_employee.service_admin?
    return unless @employee.service_admin?

    redirect_to(root_path, alert: t('errors.messages.forbidden'))
  end

  def redirect_if_admin_or_service_admin_try_to_lock_himself
    return unless @employee.eql?(current_employee)

    redirect_to(root_path, alert: t('.you_can_not_lock_yourself'))
  end

  def redirect_if_admin_or_service_admin_try_to_unlock_himself
    return unless @employee.eql?(current_employee)

    redirect_to(root_path, alert: t('.you_can_not_unlock_yourself'))
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    permitted_params = params.require(:employee)
                             .permit(:email, :password, :password_confirmation,
                                     :first_name, :last_name, :middle_name, :phone_numbers)

    permitted_params[:role] = params[:employee][:role] if (current_employee.admin? || current_employee.service_admin?) && params[:employee][:role]

    permitted_params
  end

  def allow_without_password
    return unless params[:employee][:password].blank? && params[:employee][:password_confirmation].blank?

    params[:employee].delete(:password)
    params[:employee].delete(:password_confirmation)
  end
end
