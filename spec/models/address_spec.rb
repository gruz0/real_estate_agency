# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { build(:address) }

  it 'has a valid factory' do
    expect(address).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(address).to validate_presence_of(:building_number).with_message(I18n.t('errors.messages.blank')) }
    it { expect(address).not_to validate_uniqueness_of(:building_number) }

    # Format validations
    it { expect(address).to allow_value('7а').for(:building_number) }

    # Inclusion/acceptance of values
    it { expect(address).to validate_length_of(:building_number).is_at_least(1) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(address).to belong_to(:street) }
    it { expect(address).to have_many(:estate).dependent(:restrict_with_error) }

    # Database columns/indexes
    it { expect(address).to have_db_column(:building_number).of_type(:string).with_options(null: false) }
    it { expect(address).to have_db_index(:building_number).unique(false) }

    it { expect(address).to have_db_column(:street_id).of_type(:integer).with_options(null: false) }
    it { expect(address).to have_db_index(:street_id) }
  end

  describe 'strip attributes' do
    describe '#building_number' do
      it 'returns building_number without spaces' do
        address.building_number = '    7/1а     '
        expect(address.building_number).to eq('7/1а')
      end
    end
  end

  describe 'scopes' do
    it '.with_estates returns addresses with estates' do
      city    = create(:city)
      street  = create(:street, city: city)
      address = create(:address, street: street)
      estate1 = create(:estate, address: address)
      estate2 = create(:estate, address: address, apartment_number: '1', client_phone_numbers: '+79991112233')

      address_with_estates = described_class.with_estates.first
      expect(address_with_estates.estate.size).to eq(2)
      expect(address_with_estates.estate).to include(estate1)
      expect(address_with_estates.estate).to include(estate2)
    end
  end

  describe 'public instance methods' do
    describe 'responds to its methods' do
      it { expect(address).to respond_to(:full_name) }
      it { expect(address).to respond_to(:street_name) }
    end

    describe 'executes methods correctly' do
      describe '#full_name' do
        it 'returns City, Street and building_number' do
          expect(address.full_name)
            .to eq("#{address.street.city_name}, #{address.street.name}, #{address.building_number}")
        end
      end

      describe '#street_name' do
        it 'returns Street name' do
          expect(address.street_name).to eq(address.street.name)
        end
      end
    end
  end
end
