require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PeopleController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'Client' do
    let(:person) { Person.create! valid_attributes }
    let(:valid_attributes) do
      attributes_for(:client)
    end

    include_examples :people_controller_examples
  end

  describe 'Employee' do
    let(:person) { Person.create! valid_attributes }
    let(:valid_attributes) do
      attributes_for(:employee)
    end

    include_examples :people_controller_examples
  end
end
