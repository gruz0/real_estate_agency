require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:person) { build(:employee) }

  it 'has a valid factory' do
    expect(person).to be_valid
  end

  describe 'ActiveModel validations' do
    include_examples :person_active_model_validations
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(person).to have_many(:estate).dependent(:destroy) }

    include_examples :person_active_record_associations
  end
end
