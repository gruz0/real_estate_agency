require 'rails_helper'

RSpec.describe Street, type: :model do
  it 'has a valid factory' do
    expect(build(:street)).to be_valid
  end

  let(:subject) { build(:street) }

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(subject).to validate_presence_of(:name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(subject).to validate_uniqueness_of(:name).case_insensitive }

    # Format validations
    it { expect(subject).to allow_value('7-й микрорайон').for(:name) }

    # Inclusion/acceptance of values
    it { expect(subject).to validate_length_of(:name).is_at_least(3) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(subject).to belong_to(:city) }
    it { expect(subject).to have_many(:address).dependent(:destroy) }

    # Database columns/indexes
    it { expect(subject).to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { expect(subject).to have_db_index(:name).unique }

    it { expect(subject).to have_db_column(:city_id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_index(:city_id) }
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(subject).to respond_to(:city_name) }
    end

    context 'executes methods correctly' do
      context '#city_name' do
        it 'returns City name' do
          expect(subject.city_name).to eq(subject.city.name)
        end
      end
    end
  end
end
