require 'rails_helper'

RSpec.describe Street, type: :model do
  let(:city) { create(:city) }
  let(:street) { build(:street) }

  describe 'valid factory' do
    it 'has a valid factory' do
      expect(street).to be_valid
    end

    it 'has a valid factory if name already taken in the other city' do
      other_city = create(:city)
      create(:street, city: other_city, name: 'ул. Первая')

      street = Street.new(city: city, name: 'ул. Первая')

      expect(street).to be_valid
    end

    it 'has a valid factory if name changed' do
      Street.create!(city: city, name: 'ул. Первая')

      street = Street.create!(city: city, name: 'ул. Вторая')
      street.update!(name: 'ул. Вторая')
      street.reload

      expect(street).to be_valid
    end
  end

  describe 'invalid factory' do
    it "has an invalid factory if name already taken in the street's city" do
      city = create(:city)
      create(:street, city: city, name: 'ул. Первая')

      street = Street.new(city: city, name: 'ул. Первая')
      expect(street).to be_invalid
      expect(street.errors.messages[:name]).to include(I18n.t('errors.messages.taken'))
    end
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(street).to validate_presence_of(:name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(street).not_to validate_uniqueness_of(:name) }

    # Format validations
    it { expect(street).to allow_value('7-й микрорайон').for(:name) }

    # Inclusion/acceptance of values
    it { expect(street).to validate_length_of(:name).is_at_least(3) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(street).to belong_to(:city) }
    it { expect(street).to have_many(:address).dependent(:destroy) }

    # Database columns/indexes
    it { expect(street).to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { expect(street).to have_db_index(:name) }

    it { expect(street).to have_db_column(:city_id).of_type(:integer).with_options(null: false) }
    it { expect(street).to have_db_index(:city_id) }
  end

  describe 'strip attributes' do
    describe '#name' do
      it 'returns name without spaces' do
        street.name = '    ул. Ленина     '
        expect(street.name).to eq('ул. Ленина')
      end
    end
  end

  describe 'scopes' do
    it '.ordered_by_name returns streets ordered by name ascending' do
      city    = create(:city)
      street1 = create(:street, city: city, name: 'ул. 7-й мкрн')
      street2 = create(:street, city: city, name: 'ул. Ленина')
      street3 = create(:street, city: city, name: 'ул. Арбатская')

      streets = Street.ordered_by_name
      expect(streets.size).to eq(3)
      expect(streets).to eq([street1, street3, street2])
    end
  end

  describe 'public instance methods' do
    describe 'responds to its methods' do
      it { expect(street).to respond_to(:city_name) }
    end

    describe 'executes methods correctly' do
      describe '#city_name' do
        it 'returns City name' do
          expect(street.city_name).to eq(street.city.name)
        end
      end
    end
  end
end
