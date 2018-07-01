RSpec.shared_examples :estates_controller_allow_update_action_to_admins do
  context 'with valid params' do
    it 'updates the requested estate' do
      put :update, params: { id: estate.to_param, estate: new_attributes }
      estate.reload

      expect(estate.updated_by_employee).to eq(current_employee)
      expect(estate.responsible_employee).to eq(new_attributes[:responsible_employee])
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
      put :update, params: { id: estate.to_param, estate: valid_attributes }
      expect(response).to redirect_to(estate)
    end

    it 'renders flash notice' do
      put :update, params: { id: estate.to_param, estate: valid_attributes }
      expect(flash[:notice]).to eq(I18n.t('views.estate.flash_messages.estate_was_successfully_updated'))
    end
  end

  context 'with invalid params' do
    it "returns a success response (i.e. to display the 'edit' template)" do
      put :update, params: { id: estate.to_param, estate: invalid_attributes }
      expect(response).to be_successful
    end

    it 'redirects to index page if record was not found' do
      put :update, params: { id: 42, estate: invalid_attributes }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.estate.flash_messages.estate_was_not_found'))
    end
  end
end
