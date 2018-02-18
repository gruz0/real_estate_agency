class ClientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_|
    redirect_to clients_path, alert: t('views.client.flash_messages.client_was_not_found')
  end

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
    super(Client.new(client_params), t('views.client.flash_messages.client_was_successfully_created'))
  end

  def update
    super(@client, client_params, t('views.client.flash_messages.client_was_successfully_updated'))
  end

  def destroy
    super(@client, clients_url, t('views.client.flash_messages.client_was_successfully_destroyed'))
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:full_name, :phone_numbers)
  end
end
