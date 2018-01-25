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
end
