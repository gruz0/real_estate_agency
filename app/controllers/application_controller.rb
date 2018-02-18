class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_employee!

  protected

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
    entity.destroy
    respond_to do |format|
      format.html { redirect_to redirect_url, notice: notice }
      format.json { head :no_content }
    end
  end
end
