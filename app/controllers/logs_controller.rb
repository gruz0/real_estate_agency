class LogsController < ApplicationController
  include PeopleHelper

  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to logs_path, alert: t('views.log.flash_messages.log_was_not_found')
  end

  before_action :redirect_if_employee_is_not_service_admin
  before_action :set_log, only: %i[show]

  def index
    @logs = Log.order('id DESC').page(params[:page])
  end

  def show; end

  private

  def set_log
    @log = Log.find(params[:id])
  end
end
