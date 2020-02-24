# frozen_string_literal: true

module Services
  class ReassignEstatesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound do |_|
      redirect_to services_reassign_estates_path, alert: t('views.employee.flash_messages.employee_was_not_found')
    end

    before_action :redirect_if_employee_is_not_admin_or_service_admin
    before_action :set_employee_from, only: %i[update]
    before_action :set_employee_to, only: %i[update]
    before_action :redirect_if_admin_try_to_reassign_service_admin_estates, only: %i[update]

    include PeopleHelper

    def index; end

    def update
      if created_by_employee.empty? && responsible_employee.empty?
        return redirect_to(services_reassign_estates_path, notice: t('.nothing_to_reassign'))
      end

      if created_by_employee.present?
        created_by_employee.update(created_by_employee_id: @to_employee.id,
                                   updated_by_employee_id: current_employee.id,
                                   updated_at: Time.zone.now)
      end

      if responsible_employee.present?
        responsible_employee.update(responsible_employee_id: @to_employee.id,
                                    updated_by_employee_id: current_employee.id,
                                    updated_at: Time.zone.now)
      end

      redirect_to services_reassign_estates_path,
                  notice: t('views.services.reassign_estates.flash_messages.estates_was_successfully_reassigned')
    end

    def set_employee_from
      @from_employee = Employee.find(reassign_estates_params[:from_employee])
    end

    def set_employee_to
      @to_employee = Employee.find(reassign_estates_params[:to_employee])
    end

    def reassign_estates_params
      params.require(:reassign_estates).permit(:from_employee, :to_employee)
    end

    private

    # FIXME: It should be refactored.
    # When service admin reassigns estates from self to another employee.
    # Current behaviour: it returns error message.
    # Expexted behavious: estates reassigned.
    def redirect_if_admin_try_to_reassign_service_admin_estates
      return unless @from_employee.service_admin?

      redirect_to(services_reassign_estates_path, alert: t('.you_can_not_reassign_service_admin_estates'))
    end

    def created_by_employee
      @created_by_employee ||= Estate.where(created_by_employee: @from_employee)
    end

    def responsible_employee
      @responsible_employee ||= Estate.where(responsible_employee: @from_employee)
    end
  end
end
