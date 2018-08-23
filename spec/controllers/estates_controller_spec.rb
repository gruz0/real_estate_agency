require 'rails_helper'

RSpec.describe EstatesController, type: :controller do
  let(:employee) { create(:employee) }
  let(:city) { create(:city) }
  let(:street) { create(:street, city: city) }
  let(:estate_type) { create(:estate_type) }
  let(:estate_project) { create(:estate_project) }
  let(:estate_material) { create(:estate_material) }
  let(:estate) { create(:estate, valid_attributes.except(:city, :street, :building_number)) }

  let(:valid_attributes) do
    {
      responsible_employee: employee,
      city: city,
      street: street,
      building_number: '9а',
      apartment_number: 50,
      estate_type: estate_type,
      estate_project: estate_project,
      estate_material: estate_material,
      client_full_name: 'Иванова Наталья Петровна',
      client_phone_numbers: '+79991112233',
      number_of_rooms: 3,
      floor: 4,
      number_of_floors: 9,
      total_square_meters: 103.1,
      kitchen_square_meters: 30.8,
      description: 'Описание объекта',
      price: 99_999
    }
  end

  let(:invalid_attributes) do
    {
      responsible_employee: '',
      city: '',
      street: '',
      building_number: '',
      estate_type: '',
      estate_project: '',
      estate_material: '',
      client_full_name: '',
      client_phone_numbers: '',
      number_of_rooms: 333,
      floor: 100,
      number_of_floors: 1_000,
      price: 'abc'
    }
  end

  describe 'GET #index' do
    login_employee

    it 'returns a success response' do
      estate
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    login_employee

    it 'returns a success response' do
      get :show, params: { id: estate.to_param }
      expect(response).to be_successful
    end

    it 'redirects to index page if record was not found' do
      get :show, params: { id: 100_500 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.estate.flash_messages.estate_was_not_found'))
    end
  end

  describe 'GET #new' do
    login_employee

    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    login_employee

    it 'returns a success response' do
      get :edit, params: { id: estate.to_param }
      expect(response).to be_successful
    end

    it 'redirects to index page if record was not found' do
      get :edit, params: { id: 100_500 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.estate.flash_messages.estate_was_not_found'))
    end
  end

  describe 'POST #create' do
    login_employee

    context 'with valid params' do
      it 'creates a new Estate' do
        expect do
          post :create, params: { estate: valid_attributes }
        end.to change(Estate, :count).by(1)
      end

      it 'redirects to the created estate' do
        post :create, params: { estate: valid_attributes }
        expect(response).to redirect_to(Estate.last)
      end

      it 'renders flash notice' do
        post :create, params: { estate: valid_attributes }
        expect(flash[:notice]).to eq(I18n.t('views.estate.flash_messages.estate_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { estate: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) do
      {
        responsible_employee: create(:employee),
        city: city,
        street: street,
        building_number: '11/2',
        apartment_number: 30,
        estate_type: estate_type,
        estate_project: create(:estate_project),
        estate_material: create(:estate_material),
        client_full_name: 'Сергеев Алексей Николаевич',
        client_phone_numbers: '+70001112233',
        number_of_rooms: 2,
        floor: 5,
        number_of_floors: 10,
        total_square_meters: 103.1,
        kitchen_square_meters: 30.8,
        description: 'Новое описание объекта',
        price: 88_888,
        status: :archived
      }
    end

    context 'when user is an employee' do
      login_employee

      let(:current_employee) { authenticated_employee }
      let(:estate) do
        create(:estate, valid_attributes.except(:city, :street, :building_number)
                                        .merge(created_by_employee: current_employee,
                                               responsible_employee: current_employee))
      end

      context 'with valid params' do
        it 'updates the requested estate' do
          put :update, params: { id: estate.to_param, estate: new_attributes.merge(responsible_employee: current_employee) }
          estate.reload

          expect(estate.updated_by_employee).to eq(current_employee)
          expect(estate.responsible_employee).to eq(current_employee)
          expect(estate.address).to eq(Address.last)
          expect(estate.apartment_number).to eq(new_attributes[:apartment_number].to_s)
          expect(estate.estate_type).to eq(new_attributes[:estate_type])
          expect(estate.estate_project).to eq(new_attributes[:estate_project])
          expect(estate.estate_material).to eq(new_attributes[:estate_material])
          expect(estate.client_full_name).to eq(new_attributes[:client_full_name])
          expect(estate.client_phone_numbers).to eq(new_attributes[:client_phone_numbers])
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
          put :update, params: {
            id: estate.to_param,
            estate: valid_attributes.merge(responsible_employee: current_employee)
          }
          expect(response).to redirect_to(estate)
        end

        it 'renders flash notice' do
          put :update, params: {
            id: estate.to_param,
            estate: valid_attributes.merge(responsible_employee: current_employee)
          }
          expect(flash[:notice]).to eq(I18n.t('views.estate.flash_messages.estate_was_successfully_updated'))
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          put :update, params: {
            id: estate.to_param,
            estate: invalid_attributes.merge(responsible_employee: current_employee)
          }
          expect(response).to be_successful
        end

        it 'redirects to index page if record was not found' do
          put :update, params: { id: 100_500, estate: invalid_attributes }
          expect(response).to be_redirect
          expect(flash[:alert]).to eq(I18n.t('views.estate.flash_messages.estate_was_not_found'))
        end

        context 'when estate created by current employee' do
          context 'when estate assigned to current employee' do
            let(:estate) do
              create(:estate, valid_attributes.except(:city, :street, :building_number)
                                              .merge(created_by_employee: current_employee,
                                                     responsible_employee: current_employee))
            end

            it 'renders an error if employee try to change responsible employee' do
              put :update, params: { id: estate.to_param, estate: valid_attributes }
              expect(response).to redirect_to(edit_estate_path(estate))
              expect(flash[:alert]).to eq(I18n.t('estates.update.you_can_not_change_responsible_employee'))
            end
          end

          context 'when estate was not assigned to current employee' do
            let(:estate) do
              create(:estate, valid_attributes.except(:city, :street, :building_number)
                                              .merge(created_by_employee: current_employee))
            end

            it 'renders an error if employee try to change responsible employee to himself' do
              put :update, params: {
                id: estate.to_param,
                estate: valid_attributes.merge(responsible_employee: current_employee)
              }
              expect(response).to redirect_to(edit_estate_path(estate))
              expect(flash[:alert]).to eq(I18n.t('estates.update.you_can_not_change_responsible_employee'))
            end
          end
        end

        context 'when estate was not created by current employee' do
          context 'when estate assigned to current employee' do
            let(:estate) do
              create(:estate, valid_attributes.except(:city, :street, :building_number)
                                              .merge(responsible_employee: current_employee))
            end

            it 'renders an error if employee try to change responsible employee' do
              put :update, params: { id: estate.to_param, estate: valid_attributes }
              expect(response).to redirect_to(edit_estate_path(estate))
              expect(flash[:alert]).to eq(I18n.t('estates.update.you_can_not_change_responsible_employee'))
            end
          end

          context 'when estate was not assigned to current employee' do
            let(:estate) do
              create(:estate, valid_attributes.except(:city, :street, :building_number))
            end

            it 'renders an error if employee try to update not owned record' do
              put :update, params: { id: estate.to_param, estate: valid_attributes }
              expect(response).to redirect_to(edit_estate_path(estate))
              expect(flash[:alert]).to eq(I18n.t('estates.update.you_can_not_update_not_owned_estate'))
            end
          end
        end
      end
    end

    context 'when user is an admin' do
      login_admin

      let(:current_employee) { authenticated_admin }
      include_examples :estates_controller_allow_update_action_to_admins
    end

    context 'when user is a service_admin' do
      login_service_admin

      let(:current_employee) { authenticated_service_admin }
      include_examples :estates_controller_allow_update_action_to_admins
    end
  end

  describe 'DELETE #destroy' do
    login_employee

    context 'with valid params' do
      it 'destroys the requested estate' do
        estate
        expect do
          delete :destroy, params: { id: estate.to_param }
        end.to change(Estate, :count).by(-1)
      end

      it 'redirects to the estates list' do
        delete :destroy, params: { id: estate.to_param }
        expect(response).to redirect_to(estates_url)
      end

      it 'renders flash notice' do
        delete :destroy, params: { id: estate.to_param }
        expect(flash[:notice]).to eq(I18n.t('views.estate.flash_messages.estate_was_successfully_destroyed'))
      end
    end

    context 'with invalid params' do
      it 'redirects to index page if record was not found' do
        delete :destroy, params: { id: 100_500 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.estate.flash_messages.estate_was_not_found'))
      end
    end
  end
end
