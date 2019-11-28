require 'rails_helper'

RSpec.describe EstateMaterial, type: :model do
  let(:estate_material) { build(:estate_material) }

  it 'has a valid factory' do
    expect(estate_material).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(estate_material).to validate_presence_of(:name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(estate_material).to validate_uniqueness_of(:name).case_insensitive }

    # Format validations
    it { expect(estate_material).to allow_value('Деревянный').for(:name) }

    # Inclusion/acceptance of values
    it { expect(estate_material).to validate_length_of(:name).is_at_least(3) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(estate_material).to have_many(:estate).dependent(:restrict_with_error) }

    # Database columns/indexes
    it { expect(estate_material).to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { expect(estate_material).to have_db_index(:name).unique }
  end

  describe 'modify attributes' do
    describe '#name' do
      it 'returns name without spaces' do
        estate_material.name = '    Деревянный     '
        expect(estate_material.name).to eq('Деревянный')
      end

      it 'returns name capitalized' do
        estate_material.name = 'кирпичный'
        expect(estate_material.name).to eq('Кирпичный')
      end
    end
  end

  describe 'scopes' do
    it '.ordered_by_name returns estate_materials ordered by name ascending' do
      estate_material1 = create(:estate_material, name: 'Кирпичный')
      estate_material2 = create(:estate_material, name: 'Деревянный')
      estate_material3 = create(:estate_material, name: 'Панельный')

      estate_materials = described_class.ordered_by_name
      expect(estate_materials.size).to eq(3)
      expect(estate_materials).to eq([estate_material2, estate_material1, estate_material3])
    end
  end
end
