require 'rails_helper'

RSpec.describe Street, type: :model do
  let(:street) { build(:street) }

  it 'has a valid factory' do
    expect(street).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(street).to validate_presence_of(:name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(street).to validate_uniqueness_of(:name).case_insensitive }

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
    it { expect(street).to have_db_index(:name).unique }

    it { expect(street).to have_db_column(:city_id).of_type(:integer).with_options(null: false) }
    it { expect(street).to have_db_index(:city_id) }
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
