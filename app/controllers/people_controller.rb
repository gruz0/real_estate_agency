class PeopleController < ApplicationController
  before_action :set_person, only: %i[show edit update destroy]
  before_action :set_type

  include PeopleHelper

  def index
    @people = type_class.all
  end

  def show; end

  def new
    @person = type_class.new
  end

  def edit; end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to sti_person_path(@person.type, @person), notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_type
    @type = type
  end

  def type
    Person.types.include?(params[:type]) ? params[:type] : 'Person'
  end

  def type_class
    type.constantize
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = type_class.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def person_params
    params.require(type.underscore.to_sym).permit(:type, :first_name, :last_name, :middle_name, :phone_numbers, :active)
  end
end
