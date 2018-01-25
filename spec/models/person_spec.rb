require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:person) { build(:person) }

  it 'has a valid factory' do
    expect(person).to be_valid
  end

  describe 'ActiveModel validations' do
    include_examples :person_active_model_validations
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(person).not_to have_many(:estate) }

    include_examples :person_active_record_associations
  end

  describe 'public class methods' do
    describe 'responds to its methods' do
      it { expect(Person).to respond_to(:types) }
    end

    describe 'executes methods correctly' do
      describe '#types' do
        it 'returns available types' do
          expect(Person.types).to eq(%w[Employee Client])
        end
      end
    end
  end
end
