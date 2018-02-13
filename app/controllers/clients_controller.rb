class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  include PeopleHelper

  def index
    @clients = Client.page(params[:page])
  end

  def show; end

  def new
    @client = Client.new
  end

  def edit; end

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html do
          redirect_to @client, notice: t('views.client.flash_messages.client_was_successfully_created')
        end
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html do
          redirect_to @client, notice: t('views.client.flash_messages.client_was_successfully_updated')
        end
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html do
        redirect_to clients_url, notice: t('views.client.flash_messages.client_was_successfully_destroyed')
      end
      format.json { head :no_content }
    end
  end

  private

  def set_client
    @client = Client.find_by(id: params[:id])
  end

  def client_params
    params.require(:client).permit(:full_name, :phone_numbers)
  end
end
