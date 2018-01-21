require 'rails_helper'

RSpec.describe Employee, type: :model do
  it 'has a valid factory' do
    expect(build(:employee)).to be_valid
  end

  let(:subject) { build(:employee) }

  describe 'ActiveModel validations' do
    include_examples :person_active_model_validations
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(subject).to have_many(:estate).dependent(:destroy) }

    include_examples :person_active_record_associations
  end
end
