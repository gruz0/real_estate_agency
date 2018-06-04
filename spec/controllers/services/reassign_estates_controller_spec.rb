require 'rails_helper'

RSpec.describe Services::ReassignEstatesController, type: :controller do
  describe 'GET #index' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        get :index, params: {}
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin
      include_examples :services_reassign_estates_controller_allow_index_action_to_admins
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples :services_reassign_estates_controller_allow_index_action_to_admins
    end
  end

  describe 'PUT #update' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        put :update, params: { reassign_estates: {} }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin
      let(:current_user) { authenticated_admin }

      include_examples :services_reassign_estates_controller_allow_update_action_to_admins

      context 'when from_employee is a service_admin' do
        let(:new_attributes) do
          {
            from_employee: create(:employee, role: :service_admin),
            to_employee: create(:employee)
          }
        end

        it 'redirects to services_reassign_estates_path with alert' do
          put :update, params: { reassign_estates: new_attributes }
          expect(response).to be_redirect
          expect(flash[:alert])
            .to eq(I18n.t('services.reassign_estates.update.you_can_not_reassign_service_admin_estates'))
        end
      end
    end

    context 'when user is a service_admin' do
      login_service_admin

      let(:current_user) { authenticated_service_admin }

      include_examples :services_reassign_estates_controller_allow_update_action_to_admins
    end
  end
end
