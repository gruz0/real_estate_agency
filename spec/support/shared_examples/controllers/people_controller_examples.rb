RSpec.shared_examples :people_controller_examples do
  let(:invalid_attributes) do
    {
      type: 'Person',
      last_name: '',
      first_name: '',
      phone_numbers: ''
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      person
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: person.to_param }, session: valid_session
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
      get :edit, params: { id: person.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Person' do
        expect do
          post :create, params: { person: valid_attributes }, session: valid_session
        end.to change(Person, :count).by(1)
      end

      it 'redirects to the created person' do
        post :create, params: { person: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Person.last)
      end

      it 'renders flash notice' do
        post :create, params: { person: valid_attributes }, session: valid_session
        expect(flash[:notice])
          .to eq(I18n.t('views.person.flash_messages.person_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { person: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          last_name: FFaker::NameRU.last_name,
          first_name: FFaker::NameRU.first_name,
          middle_name: FFaker::NameRU.patronymic,
          phone_numbers: FFaker::PhoneNumber.phone_number,
          active: 0
        }
      end

      it 'updates the requested person' do
        put :update, params: { id: person.to_param, person: new_attributes }, session: valid_session
        person.reload

        expect(person.last_name).to eq(new_attributes[:last_name])
        expect(person.first_name).to eq(new_attributes[:first_name])
        expect(person.middle_name).to eq(new_attributes[:middle_name])
        expect(person.phone_numbers).to eq(new_attributes[:phone_numbers])
        expect(person.active).to eq(new_attributes[:active])
      end

      it 'redirects to the person' do
        put :update, params: { id: person.to_param, person: valid_attributes }, session: valid_session
        expect(response).to redirect_to(person)
      end

      it 'renders flash notice' do
        put :update, params: { id: person.to_param, person: valid_attributes }, session: valid_session
        expect(flash[:notice])
          .to eq(I18n.t('views.person.flash_messages.person_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: person.to_param, person: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested person' do
      person
      expect do
        delete :destroy, params: { id: person.to_param }, session: valid_session
      end.to change(Person, :count).by(-1)
    end

    it 'redirects to the people list' do
      delete :destroy, params: { id: person.to_param }, session: valid_session
      expect(response).to redirect_to(people_url)
    end

    it 'renders flash notice' do
      delete :destroy, params: { id: person.to_param }, session: valid_session
      expect(flash[:notice])
        .to eq(I18n.t('views.person.flash_messages.person_was_successfully_destroyed'))
    end
  end
end
