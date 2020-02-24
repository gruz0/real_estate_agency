# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EstateType, type: :model do
  let(:estate_type) { build(:estate_type) }

  it 'has a valid factory' do
    expect(estate_type).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(estate_type).to validate_presence_of(:name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(estate_type).to validate_uniqueness_of(:name).case_insensitive }

    # Format validations
    it { expect(estate_type).to allow_value('Дом').for(:name) }

    # Inclusion/acceptance of values
    it { expect(estate_type).to validate_length_of(:name).is_at_least(3) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(estate_type).to have_many(:estate).dependent(:restrict_with_error) }

    # Database columns/indexes
    it { expect(estate_type).to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { expect(estate_type).to have_db_index(:name).unique }
  end

  describe 'modify attributes' do
    describe '#name' do
      it 'returns name without spaces' do
        estate_type.name = '    Квартира     '
        expect(estate_type.name).to eq('Квартира')
      end

      it 'returns name capitalized' do
        estate_type.name = 'дом'
        expect(estate_type.name).to eq('Дом')
      end
    end
  end

  describe 'scopes' do
    it '.ordered_by_name returns estate_types ordered by name ascending' do
      estate_type1 = create(:estate_type, name: 'Дом')
      estate_type2 = create(:estate_type, name: 'Комната')
      estate_type3 = create(:estate_type, name: 'Квартира')

      estate_types = described_class.ordered_by_name
      expect(estate_types.size).to eq(3)
      expect(estate_types).to eq([estate_type1, estate_type3, estate_type2])
    end
  end
end
