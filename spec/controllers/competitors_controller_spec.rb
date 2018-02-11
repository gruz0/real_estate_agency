require 'rails_helper'

RSpec.describe CompetitorsController, type: :controller do
  let(:competitor) { Competitor.create! valid_attributes }

  let(:valid_attributes) do
    attributes_for(:competitor)
  end

  let(:invalid_attributes) do
    {
      phone_numbers: ''
    }
  end

  describe 'GET #index' do
    login_employee

    it 'returns a success response' do
      competitor
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    login_employee

    it 'returns a success response' do
      get :show, params: { id: competitor.to_param }
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    login_employee

    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    login_employee

    it 'returns a success response' do
      get :edit, params: { id: competitor.to_param }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    login_employee

    context 'with valid params' do
      it 'creates a new Competitor' do
        expect do
          post :create, params: { competitor: valid_attributes }
        end.to change(Competitor, :count).by(1)
      end

      it 'redirects to the created competitor' do
        post :create, params: { competitor: valid_attributes }
        expect(response).to redirect_to(Competitor.last)
      end

      it 'renders flash notice' do
        post :create, params: { competitor: valid_attributes }
        expect(flash[:notice])
          .to eq(I18n.t('views.competitor.flash_messages.competitor_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { competitor: invalid_attributes }
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    login_employee

    context 'with valid params' do
      let(:new_attributes) do
        {
          name: "#{FFaker::NameRU.last_name} #{FFaker::NameRU.first_name}",
          phone_numbers: '+79993334455'
        }
      end

      it 'updates the requested competitor' do
        put :update, params: { id: competitor.to_param, competitor: new_attributes }
        competitor.reload

        expect(competitor.name).to eq(new_attributes[:name])
        expect(competitor.phone_numbers).to eq(new_attributes[:phone_numbers])
      end

      it 'redirects to the competitor' do
        put :update, params: { id: competitor.to_param, competitor: valid_attributes }
        expect(response).to redirect_to(competitor)
      end

      it 'renders flash notice' do
        put :update, params: { id: competitor.to_param, competitor: valid_attributes }
        expect(flash[:notice])
          .to eq(I18n.t('views.competitor.flash_messages.competitor_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: competitor.to_param, competitor: invalid_attributes }
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    login_employee

    it 'destroys the requested competitor' do
      competitor
      expect do
        delete :destroy, params: { id: competitor.to_param }
      end.to change(Competitor, :count).by(-1)
    end

    it 'redirects to the competitors list' do
      delete :destroy, params: { id: competitor.to_param }
      expect(response).to redirect_to(competitors_url)
    end

    it 'renders flash notice' do
      delete :destroy, params: { id: competitor.to_param }
      expect(flash[:notice])
        .to eq(I18n.t('views.competitor.flash_messages.competitor_was_successfully_destroyed'))
    end
  end
end
