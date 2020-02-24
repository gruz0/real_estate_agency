# frozen_string_literal: true

RSpec.shared_examples 'employees controller allow index action to admins' do
  it 'returns a success response' do
    get :index, params: {}
    expect(response).to be_successful
  end
end

RSpec.shared_examples 'employees controller allow show action to admins' do
  it 'returns a success response' do
    get :show, params: { id: employee.to_param }
    expect(response).to be_successful
  end

  it 'redirects to index page if record was not found' do
    get :show, params: { id: 100_500 }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('views.employee.flash_messages.employee_was_not_found'))
  end
end

RSpec.shared_examples 'employees controller allow new action to admins' do
  it 'returns a success response' do
    get :new, params: {}
    expect(response).to be_successful
  end
end

RSpec.shared_examples 'employees controller allow edit action to admins' do
  it 'returns a success response' do
    get :edit, params: { id: employee.to_param }
    expect(response).to be_successful
  end

  it 'redirects to index page if record was not found' do
    get :edit, params: { id: 100_500 }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('views.employee.flash_messages.employee_was_not_found'))
  end
end

RSpec.shared_examples 'employees controller allow create action to admins' do
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
      expect(response).to be_successful
    end
  end
end

RSpec.shared_examples 'employees controller allow update action to admins' do
  context 'with valid params' do
    let(:new_attributes) do
      {
        last_name: FFaker::NameRU.last_name,
        first_name: FFaker::NameRU.first_name,
        middle_name: FFaker::NameRU.middle_name_male,
        phone_numbers: '+79991112233',
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
      expect(response).to be_successful
    end

    it 'redirects to index page if record was not found' do
      put :update, params: { id: 100_500, employee: invalid_attributes }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.employee.flash_messages.employee_was_not_found'))
    end
  end
end

RSpec.shared_examples 'employees controller allow lock action to admins' do
  context 'with valid params' do
    it 'redirects to the employees list' do
      post :lock, params: { id: employee.to_param }
      expect(response).to redirect_to(employees_url)
    end

    it 'renders flash notice' do
      post :lock, params: { id: employee.to_param }
      expect(flash[:notice])
        .to eq(I18n.t('views.employee.flash_messages.employee_was_successfully_locked'))
    end
  end

  context 'with invalid params' do
    it 'redirects to index page if record was not found' do
      post :lock, params: { id: 100_500 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.employee.flash_messages.employee_was_not_found'))
    end
  end
end

RSpec.shared_examples 'employees controller prevent to lock yourself' do
  it 'redirects to root_path with alert' do
    post :lock, params: { id: current_employee.to_param }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('employees.lock.you_can_not_lock_yourself'))
  end
end

RSpec.shared_examples 'employees controller allow unlock action to admins' do
  context 'with valid params' do
    it 'redirects to the employees list' do
      post :unlock, params: { id: employee.to_param }
      expect(response).to redirect_to(employees_url)
    end

    it 'renders flash notice' do
      post :unlock, params: { id: employee.to_param }
      expect(flash[:notice])
        .to eq(I18n.t('views.employee.flash_messages.employee_was_successfully_unlocked'))
    end
  end

  context 'with invalid params' do
    it 'redirects to index page if record was not found' do
      post :unlock, params: { id: 100_500 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.employee.flash_messages.employee_was_not_found'))
    end
  end
end

RSpec.shared_examples 'employees controller prevent to unlock yourself' do
  it 'redirects to root_path with alert' do
    post :unlock, params: { id: current_employee.to_param }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('employees.unlock.you_can_not_unlock_yourself'))
  end
end
