RSpec.shared_examples :employees_controller_allow_index_action_to_admins do
  it 'returns a success response' do
    get :index, params: {}
    expect(response).to be_success
  end
end

RSpec.shared_examples :employees_controller_allow_show_action_to_admins do
  it 'returns a success response' do
    get :show, params: { id: employee.to_param }
    expect(response).to be_success
  end

  it 'redirects to index page if record was not found' do
    get :show, params: { id: 42 }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('views.employee.flash_messages.employee_was_not_found'))
  end
end

RSpec.shared_examples :employees_controller_allow_new_action_to_admins do
  it 'returns a success response' do
    get :new, params: {}
    expect(response).to be_success
  end
end

RSpec.shared_examples :employees_controller_allow_edit_action_to_admins do
  it 'returns a success response' do
    get :edit, params: { id: employee.to_param }
    expect(response).to be_success
  end

  it 'redirects to index page if record was not found' do
    get :edit, params: { id: 42 }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('views.employee.flash_messages.employee_was_not_found'))
  end
end

RSpec.shared_examples :employees_controller_allow_create_action_to_admins do
  context 'with valid params' do
    it 'creates a new Employee' do
      expect do
        post :create, params: { employee: valid_attributes }
      end.to change(Employee, :count).by(1)
    end

    it 'redirects to the created employee' do
      post :create, params: { employee: valid_attributes }
      expect(response).to redirect_to(Employee.last)
    end

    it 'renders flash notice' do
      post :create, params: { employee: valid_attributes }
      expect(flash[:notice])
        .to eq(I18n.t('views.employee.flash_messages.employee_was_successfully_created'))
    end
  end

  context 'with invalid params' do
    it "returns a success response (i.e. to display the 'new' template)" do
      post :create, params: { employee: invalid_attributes }
      expect(response).to be_success
    end
  end
end

RSpec.shared_examples :employees_controller_allow_update_action_to_admins do
  context 'with valid params' do
    let(:new_attributes) do
      {
        last_name: FFaker::NameRU.last_name,
        first_name: FFaker::NameRU.first_name,
        middle_name: FFaker::NameRU.patronymic,
        phone_numbers: FFaker::PhoneNumber.phone_number,
        role: 'admin'
      }
    end

    it 'updates the requested employee' do
      put :update, params: { id: employee.to_param, employee: new_attributes }
      employee.reload

      expect(employee.last_name).to eq(new_attributes[:last_name])
      expect(employee.first_name).to eq(new_attributes[:first_name])
      expect(employee.middle_name).to eq(new_attributes[:middle_name])
      expect(employee.phone_numbers).to eq(new_attributes[:phone_numbers])
      expect(employee.role).to eq(new_attributes[:role])
    end

    it 'redirects to the employee' do
      put :update, params: { id: employee.to_param, employee: valid_attributes }
      expect(response).to redirect_to(employee)
    end

    it 'renders flash notice' do
      put :update, params: { id: employee.to_param, employee: valid_attributes }
      expect(flash[:notice])
        .to eq(I18n.t('views.employee.flash_messages.employee_was_successfully_updated'))
    end
  end

  context 'with invalid params' do
    it "returns a success response (i.e. to display the 'edit' template)" do
      put :update, params: { id: employee.to_param, employee: invalid_attributes }
      expect(response).to be_success
    end

    it 'redirects to index page if record was not found' do
      put :update, params: { id: 42, employee: invalid_attributes }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.employee.flash_messages.employee_was_not_found'))
    end
  end
end

RSpec.shared_examples :employees_controller_allow_destroy_action_to_admins do
  context 'with valid params' do
    it 'destroys the requested employee' do
      employee
      expect do
        delete :destroy, params: { id: employee.to_param }
      end.to change(Employee, :count).by(-1)
    end

    it 'redirects to the employees list' do
      delete :destroy, params: { id: employee.to_param }
      expect(response).to redirect_to(employees_url)
    end

    it 'renders flash notice' do
      delete :destroy, params: { id: employee.to_param }
      expect(flash[:notice])
        .to eq(I18n.t('views.employee.flash_messages.employee_was_successfully_destroyed'))
    end
  end

  context 'with invalid params' do
    it 'redirects to index page if record was not found' do
      delete :destroy, params: { id: 42 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.employee.flash_messages.employee_was_not_found'))
    end

    it 'redirects to index page if dependent association exists' do
      create(:estate, responsible_employee: employee)

      delete :destroy, params: { id: employee.to_param }
      expect(response).to be_redirect
      expect(flash[:alert])
        .to eq(I18n.t('activerecord.errors.messages.restrict_dependent_destroy.has_many', record: :estate))
    end
  end
end

RSpec.shared_examples :employees_controller_prevent_to_destroy_yourself do
  it 'redirects to root_path with alert' do
    delete :destroy, params: { id: current_employee.to_param }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('employees.destroy.you_can_not_destroy_yourself'))
  end
end
