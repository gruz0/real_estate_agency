class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]

  include PeopleHelper

  def index
    @employees = Employee.all
  end

  def show; end

  def new
    @employee = Employee.new
  end

  def edit; end

  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html do
          redirect_to @employee, notice: t('views.employee.flash_messages.employee_was_successfully_created')
        end
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html do
          redirect_to @employee, notice: t('views.employee.flash_messages.employee_was_successfully_updated')
        end
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html do
        redirect_to employees_url, notice: t('views.employee.flash_messages.employee_was_successfully_destroyed')
      end
      format.json { head :no_content }
    end
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :middle_name, :phone_numbers)
  end
end
