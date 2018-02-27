class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_employee!

  protected

  def redirect_if_employee_is_not_admin
    redirect_to(root_path, alert: t('errors.messages.forbidden')) unless current_employee.admin?
  end

  def create(entity, notice)
    instance_variable_set("@#{entity.class.name.downcase}", entity)

    respond_to do |format|
      if entity.save
        format.html { redirect_to entity, notice: notice }
        format.json { render :show, status: :created, location: entity }
      else
        format.html { render :new }
        format.json { render json: entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update(entity, entity_params, notice)
    respond_to do |format|
      if entity.update(entity_params)
        format.html { redirect_to entity, notice: notice }
        format.json { render :show, status: :ok, location: entity }
      else
        format.html { render :edit }
        format.json { render json: entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy(entity, redirect_url, notice)
    respond_to do |format|
      if entity.destroy
        format.html { redirect_to redirect_url, notice: notice }
        format.json { head :no_content }
      else
        format.html { redirect_to redirect_url, alert: entity.errors.full_messages.join }
        format.json { render json: entity.errors, status: :unprocessable_entity }
      end
    end
  end
end
