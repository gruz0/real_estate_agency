require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:employee) { Employee.create! valid_attributes }

  let(:valid_attributes) do
    attributes_for(:employee)
  end

  let(:invalid_attributes) do
    {
      email: '',
      password: '',
      last_name: '',
      first_name: '',
      phone_numbers: ''
    }
  end

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

      it 'returns a success response' do
        employee
        get :index, params: {}
        expect(response).to be_success
      end
    end
  end

  describe 'GET #show' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        get :show, params: { id: employee.to_param }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

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
  end

  describe 'GET #new' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        get :new, params: {}
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

      it 'returns a success response' do
        get :new, params: {}
        expect(response).to be_success
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        get :edit, params: { id: employee.to_param }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

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
  end

  describe 'POST #create' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        post :create, params: { employee: valid_attributes }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

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
  end

  describe 'PUT #update' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        put :update, params: { id: employee.to_param, employee: {} }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

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
  end

  describe 'DELETE #destroy' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        delete :destroy, params: { id: employee.to_param }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

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
  end
end
