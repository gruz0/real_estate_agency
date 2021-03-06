# frozen_string_literal: true

module ControllersMacros
  def login_employee
    before do
      @request.env['devise.mapping'] = Devise.mappings[:employee]
      sign_in authenticated_employee
    end
  end

  def login_admin
    before do
      @request.env['devise.mapping'] = Devise.mappings[:employee]
      sign_in authenticated_admin
    end
  end

  def login_service_admin
    before do
      @request.env['devise.mapping'] = Devise.mappings[:employee]
      sign_in authenticated_service_admin
    end
  end
end
