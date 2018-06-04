RSpec.shared_examples :services_reassign_estates_controller_allow_index_action_to_admins do
  it 'returns a success response' do
    get :index, params: {}
    expect(response).to be_successful
  end
end

RSpec.shared_examples :services_reassign_estates_controller_allow_update_action_to_admins do
  let(:from_employee) { create(:employee) }
  let(:to_employee) { create(:employee) }
  let(:new_attributes) do
    {
      from_employee: from_employee,
      to_employee: to_employee
    }
  end

  context 'with valid params' do
    it 'updates #created_by_employee column' do
      create(:estate, created_by_employee: from_employee)

      put :update, params: { reassign_estates: new_attributes }
      expect(Estate.first.created_by_employee).to eq(to_employee)
    end

    it 'updates #responsible_employee column' do
      create(:estate, responsible_employee: from_employee)

      put :update, params: { reassign_estates: new_attributes }
      expect(Estate.first.responsible_employee).to eq(to_employee)
    end

    it 'redirects to the employee' do
      put :update, params: { reassign_estates: new_attributes }
      expect(response).to redirect_to(services_reassign_estates_path)
    end

    it 'renders flash notice if estates successfully reassigned' do
      estate1 = create(:estate, created_by_employee: from_employee)
      estate2 = create(:estate, responsible_employee: from_employee)

      put :update, params: { reassign_estates: new_attributes }
      expect(flash[:notice])
        .to eq(I18n.t('views.services.reassign_estates.flash_messages.estates_was_successfully_reassigned'))

      estate1.reload
      expect(estate1.created_by_employee).to eq(to_employee)
      expect(estate1.updated_by_employee).to eq(current_user)
      expect(estate1.updated_at).not_to be_nil

      estate2.reload
      expect(estate2.responsible_employee).to eq(to_employee)
      expect(estate2.updated_by_employee).to eq(current_user)
      expect(estate2.updated_at).not_to be_nil
    end

    it 'renders flash notice if nothing to reassign' do
      put :update, params: { reassign_estates: new_attributes }
      expect(flash[:notice]).to eq(I18n.t('services.reassign_estates.update.nothing_to_reassign'))
    end
  end

  context 'with invalid params' do
    after do
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.employee.flash_messages.employee_was_not_found'))
    end

    it 'redirects to index page if from_employee was not found' do
      put :update, params: { reassign_estates: new_attributes.merge(from_employee: 42) }
    end

    it 'redirects to index page if to_employee was not found' do
      put :update, params: { reassign_estates: new_attributes.merge(to_employee: 42) }
    end
  end
end
