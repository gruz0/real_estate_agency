require 'rails_helper'

RSpec.describe EstatesController, type: :controller do
  let(:client) { create(:client) }
  let(:employee) { create(:employee) }
  let(:city) { create(:city) }
  let(:street) { create(:street, city: city) }
  let(:estate_type) { create(:estate_type) }
  let(:estate_project) { create(:estate_project) }
  let(:estate_material) { create(:estate_material) }
  let(:estate) { create(:estate, valid_attributes.except(:city, :street, :building_number)) }

  let(:valid_attributes) do
    {
      deal_type: :sale,
      client: client,
      created_by_employee: employee,
      responsible_employee: employee,
      city: city,
      street: street,
      building_number: '9а',
      apartment_number: 50,
      estate_type: estate_type,
      estate_project: estate_project,
      estate_material: estate_material,
      number_of_rooms: 3,
      floor: 4,
      number_of_floors: 9,
      total_square_meters: 103.1,
      kitchen_square_meters: 30.8,
      description: 'Описание объекта',
      price: 99_999.99
    }
  end

  let(:invalid_attributes) do
    {
      client: '',
      created_by_employee: '',
      responsible_employee: '',
      city: '',
      street: '',
      building_number: '',
      estate_type: '',
      estate_project: '',
      estate_material: '',
      number_of_rooms: 333,
      floor: 100,
      number_of_floors: 1_000,
      price: 'abc'
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EstatesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      estate
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: estate.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: estate.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Estate' do
        expect do
          post :create, params: { estate: valid_attributes }, session: valid_session
        end.to change(Estate, :count).by(1)
      end

      it 'redirects to the created estate' do
        post :create, params: { estate: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Estate.last)
      end

      it 'renders flash notice' do
        post :create, params: { estate: valid_attributes }, session: valid_session
        expect(flash[:notice]).to eq(I18n.t('views.estate.flash_messages.estate_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { estate: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          deal_type: :rent,
          client: create(:client),
          created_by_employee: create(:employee),
          responsible_employee: create(:employee),
          city: city,
          street: street,
          building_number: '11/2',
          apartment_number: 30,
          estate_type: estate_type,
          estate_project: create(:estate_project),
          estate_material: create(:estate_material),
          number_of_rooms: 2,
          floor: 5,
          number_of_floors: 10,
          total_square_meters: 103.1,
          kitchen_square_meters: 30.8,
          description: 'Новое описание объекта',
          price: 1_000_000.00,
          status: :archived
        }
      end

      it 'updates the requested estate' do
        put :update, params: { id: estate.to_param, estate: new_attributes }, session: valid_session
        estate.reload

        expect(estate.deal_type).to eq(new_attributes[:deal_type].to_s)
        expect(estate.client).to eq(new_attributes[:client])
        expect(estate.created_by_employee).to eq(new_attributes[:created_by_employee])
        expect(estate.responsible_employee).to eq(new_attributes[:responsible_employee])
        expect(estate.address).to eq(Address.last)
        expect(estate.apartment_number).to eq(new_attributes[:apartment_number].to_s)
        expect(estate.estate_type).to eq(new_attributes[:estate_type])
        expect(estate.estate_project).to eq(new_attributes[:estate_project])
        expect(estate.estate_material).to eq(new_attributes[:estate_material])
        expect(estate.number_of_rooms).to eq(new_attributes[:number_of_rooms])
        expect(estate.floor).to eq(new_attributes[:floor])
        expect(estate.number_of_floors).to eq(new_attributes[:number_of_floors])
        expect(estate.total_square_meters).to eq(new_attributes[:total_square_meters])
        expect(estate.kitchen_square_meters).to eq(new_attributes[:kitchen_square_meters])
        expect(estate.description).to eq(new_attributes[:description])
        expect(estate.price).to eq(new_attributes[:price])
        expect(estate.status).to eq(new_attributes[:status].to_s)
      end

      it 'redirects to the estate' do
        put :update, params: { id: estate.to_param, estate: valid_attributes }, session: valid_session
        expect(response).to redirect_to(estate)
      end

      it 'renders flash notice' do
        put :update, params: { id: estate.to_param, estate: valid_attributes }, session: valid_session
        expect(flash[:notice]).to eq(I18n.t('views.estate.flash_messages.estate_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: estate.to_param, estate: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested estate' do
      estate
      expect do
        delete :destroy, params: { id: estate.to_param }, session: valid_session
      end.to change(Estate, :count).by(-1)
    end

    it 'redirects to the estates list' do
      delete :destroy, params: { id: estate.to_param }, session: valid_session
      expect(response).to redirect_to(estates_url)
    end

    it 'renders flash notice' do
      delete :destroy, params: { id: estate.to_param }, session: valid_session
      expect(flash[:notice]).to eq(I18n.t('views.estate.flash_messages.estate_was_successfully_destroyed'))
    end
  end
end
