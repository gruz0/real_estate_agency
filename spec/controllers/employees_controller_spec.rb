require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EmployeesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:employee) { Employee.create! valid_attributes }

  let(:valid_attributes) do
    attributes_for(:employee)
  end

  let(:invalid_attributes) do
    {
      last_name: '',
      first_name: '',
      phone_numbers: ''
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      employee
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: employee.to_param }, session: valid_session
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
      get :edit, params: { id: employee.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Employee' do
        expect do
          post :create, params: { employee: valid_attributes }, session: valid_session
        end.to change(Employee, :count).by(1)
      end

      it 'redirects to the created employee' do
        post :create, params: { employee: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Employee.last)
      end

      it 'renders flash notice' do
        post :create, params: { employee: valid_attributes }, session: valid_session
        expect(flash[:notice])
          .to eq(I18n.t('views.employee.flash_messages.employee_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { employee: invalid_attributes }, session: valid_session
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
          phone_numbers: FFaker::PhoneNumber.phone_number
        }
      end

      it 'updates the requested employee' do
        put :update, params: { id: employee.to_param, employee: new_attributes }, session: valid_session
        employee.reload

        expect(employee.last_name).to eq(new_attributes[:last_name])
        expect(employee.first_name).to eq(new_attributes[:first_name])
        expect(employee.middle_name).to eq(new_attributes[:middle_name])
        expect(employee.phone_numbers).to eq(new_attributes[:phone_numbers])
      end

      it 'redirects to the employee' do
        put :update, params: { id: employee.to_param, employee: valid_attributes }, session: valid_session
        expect(response).to redirect_to(employee)
      end

      it 'renders flash notice' do
        put :update, params: { id: employee.to_param, employee: valid_attributes }, session: valid_session
        expect(flash[:notice])
          .to eq(I18n.t('views.employee.flash_messages.employee_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: employee.to_param, employee: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested employee' do
      employee
      expect do
        delete :destroy, params: { id: employee.to_param }, session: valid_session
      end.to change(Employee, :count).by(-1)
    end

    it 'redirects to the employees list' do
      delete :destroy, params: { id: employee.to_param }, session: valid_session
      expect(response).to redirect_to(employees_url)
    end

    it 'renders flash notice' do
      delete :destroy, params: { id: employee.to_param }, session: valid_session
      expect(flash[:notice])
        .to eq(I18n.t('views.employee.flash_messages.employee_was_successfully_destroyed'))
    end
  end
end
