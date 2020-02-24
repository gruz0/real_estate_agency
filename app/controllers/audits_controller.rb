# frozen_string_literal: true

class AuditsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to audits_path, alert: t('views.audit.flash_messages.audit_was_not_found')
  end

  before_action :redirect_if_employee_is_not_service_admin
  before_action :set_audit, only: %i[show]

  def index
    @audits = Audited::Audit.order('id DESC').page(params[:page])
  end

  def show; end

  private

  def set_audit
    @audit = Audited::Audit.find(params[:id])
  end
end
