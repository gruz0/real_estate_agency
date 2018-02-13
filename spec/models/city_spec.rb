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

  describe 'scopes' do
    it '.with_streets returns only cities with streets' do
      create(:city, name: 'Without Streets')

      city1 = create(:city)
      city2 = create(:city)

      create(:street, city: city1)
      create(:street, city: city1)
      create(:street, city: city2)

      cities_with_streets = City.with_streets
      expect(cities_with_streets.size).to eq(2)
      expect(cities_with_streets).to include(city1)
      expect(cities_with_streets).to include(city2)
    end
  end
end
