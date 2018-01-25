require 'rails_helper'

RSpec.describe City, type: :model do
  let(:city) { build(:city) }

  it 'has a valid factory' do
    expect(city).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(city).to validate_presence_of(:name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(city).to validate_uniqueness_of(:name).case_insensitive }

    # Format validations
    it { expect(city).to allow_value('Пыть-Ях').for(:name) }

    # Inclusion/acceptance of values
    it { expect(city).to validate_length_of(:name).is_at_least(3) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(city).to have_many(:street).dependent(:destroy) }

    # Database columns/indexes
    it { expect(city).to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { expect(city).to have_db_index(:name).unique }
  end
end
