require 'rails_helper'

RSpec.describe EstateMaterial, type: :model do
  it 'has a valid factory' do
    expect(build(:estate_material)).to be_valid
  end

  let(:subject) { build(:estate_material) }

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(subject).to validate_presence_of(:name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(subject).to validate_uniqueness_of(:name).case_insensitive }

    # Format validations
    it { expect(subject).to allow_value('Деревянный').for(:name) }

    # Inclusion/acceptance of values
    it { expect(subject).to validate_length_of(:name).is_at_least(3) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(subject).to have_many(:estate).dependent(:destroy) }

    # Database columns/indexes
    it { expect(subject).to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { expect(subject).to have_db_index(:name).unique }
  end
end
