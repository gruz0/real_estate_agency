require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'has a valid factory' do
    expect(build(:address)).to be_valid
  end

  let(:subject) { build(:address) }

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(subject).to validate_presence_of(:building_number).with_message("can't be blank") }
    it { expect(subject).not_to validate_uniqueness_of(:building_number) }

    it { expect(subject).not_to validate_presence_of(:apartment_number) }
    it { expect(subject).not_to validate_uniqueness_of(:apartment_number) }

    # Format validations
    it { expect(subject).to allow_value('7а').for(:building_number) }
    it { expect(subject).to allow_value('55').for(:apartment_number) }

    # Inclusion/acceptance of values
    it { expect(subject).to validate_length_of(:building_number).is_at_least(1) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(subject).to belong_to(:street) }
    it { expect(subject).to have_many(:estate).dependent(:destroy) }

    # Database columns/indexes
    it { expect(subject).to have_db_column(:building_number).of_type(:string).with_options(null: false) }
    it { expect(subject).to have_db_index(:building_number).unique(false) }

    it { expect(subject).to have_db_column(:apartment_number).of_type(:string).with_options(null: true) }
    it { expect(subject).not_to have_db_index(:apartment_number) }

    it { expect(subject).to have_db_column(:street_id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_index(:street_id) }
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(subject).to respond_to(:full_name) }
    end

    context 'executes methods correctly' do
      context '#full_name' do
        it 'returns City, Street and building_number' do
          expect(subject.full_name)
            .to eq("#{subject.street.city_name}, #{subject.street.name}, #{subject.building_number}")
        end
      end
    end
  end
end
