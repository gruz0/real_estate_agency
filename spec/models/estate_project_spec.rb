require 'rails_helper'

RSpec.describe EstateProject, type: :model do
  let(:estate_project) { build(:estate_project) }

  it 'has a valid factory' do
    expect(estate_project).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(estate_project).to validate_presence_of(:name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(estate_project).to validate_uniqueness_of(:name).case_insensitive }

    # Format validations
    it { expect(estate_project).to allow_value('Уральский').for(:name) }

    # Inclusion/acceptance of values
    it { expect(estate_project).to validate_length_of(:name).is_at_least(3) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(estate_project).to have_many(:estate).dependent(:destroy) }

    # Database columns/indexes
    it { expect(estate_project).to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { expect(estate_project).to have_db_index(:name).unique }
  end

  describe 'strip attributes' do
    describe '#name' do
      it 'returns name without spaces' do
        estate_project.name = '    Уральский     '
        expect(estate_project.name).to eq('Уральский')
      end
    end
  end

  describe 'scopes' do
    it '.ordered_by_name returns estate_projects ordered by name ascending' do
      estate_project1 = create(:estate_project, name: 'Уральский')
      estate_project2 = create(:estate_project, name: 'Московский')
      estate_project3 = create(:estate_project, name: 'Новый')

      estate_projects = EstateProject.ordered_by_name
      expect(estate_projects.size).to eq(3)
      expect(estate_projects).to eq([estate_project2, estate_project3, estate_project1])
    end
  end
end
