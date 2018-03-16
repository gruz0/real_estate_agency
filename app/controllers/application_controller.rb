class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_employee!
  after_action :log_action, only: %i[create update destroy], unless: -> { Rails.env.test? }

  protected

  def redirect_if_employee_is_not_admin_or_service_admin
    return if current_employee.admin? || current_employee.service_admin?
    redirect_to(root_path, alert: t('errors.messages.forbidden'))
  end

  def redirect_if_employee_is_not_service_admin
    return if current_employee.service_admin?
    redirect_to(root_path, alert: t('errors.messages.forbidden'))
  end

  def create(entity, notice)
    instance_variable_set("@#{entity.class.name.downcase}", entity)
    instance_variable_set('@entity', entity)

    if entity.save
      redirect_to entity, notice: notice
    else
      render :new
    end
  end

  def update(entity, entity_params, notice)
    instance_variable_set('@entity', entity)

    if entity.update(entity_params)
      redirect_to entity, notice: notice
    else
      render :edit
    end
  end

  def destroy(entity, redirect_url, notice)
    instance_variable_set('@entity', entity)

    if entity.destroy
      redirect_to redirect_url, notice: notice
    else
      redirect_to redirect_url, alert: entity.errors.full_messages.join
    end
  end

  private

  def log_action
    form_params = params.to_unsafe_h.slice(@entity.class.name.downcase)

    log = Log.create!(
      employee_id: current_employee.id,
      controller: self.class.to_s,
      action: action_name,
      entity_id: @entity.id.to_i,
      params: form_params,
      error_messages: @entity.errors.messages.blank? ? nil : @entity.errors.full_messages.join(', '),
      flash_notice: flash[:notice]
    )

    Rails.logger.debug log.inspect if Rails.env.development?
  end
end
