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
      created_by_employee = Estate.select(:id).where(created_by_employee: @from_employee)
      responsible_employee = Estate.select(:id).where(responsible_employee: @from_employee)

      if created_by_employee.empty? && responsible_employee.empty?
        return redirect_to(services_reassign_estates_path, notice: t('.nothing_to_reassign'))
      end

      if created_by_employee.present?
        created_by_employee.update_all(created_by_employee_id: @to_employee.id,
                                       updated_by_employee_id: current_employee.id,
                                       updated_at: Time.zone.now)
      end

      if responsible_employee.present?
        responsible_employee.update_all(responsible_employee_id: @to_employee.id,
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

    def redirect_if_admin_try_to_reassign_service_admin_estates
      return unless @from_employee.service_admin?
      redirect_to(services_reassign_estates_path, alert: t('.you_can_not_reassign_service_admin_estates'))
    end
  end
end
