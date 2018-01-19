require 'rails_helper'

RSpec.describe Person, type: :model do
  it 'has a valid factory' do
    expect(build(:person)).to be_valid
  end

  let(:subject) { build(:person) }

  describe 'ActiveModel validations' do
    include_examples :person_active_model_validations
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(subject).not_to have_many(:estate) }

    include_examples :person_active_record_associations
  end

  describe 'public class methods' do
    context 'responds to its methods' do
      it { expect(Person).to respond_to(:types) }
    end

    context 'executes methods correctly' do
      context '#types' do
        it 'returns available types' do
          expect(Person.types).to eq(%w[Employee Client])
        end
      end
    end
  end
end
