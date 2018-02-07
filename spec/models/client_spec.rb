require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:person) { build(:client) }

  it 'has a valid factory' do
    expect(person).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(person).to validate_presence_of(:full_name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(person).to validate_presence_of(:phone_numbers).with_message(I18n.t('errors.messages.blank')) }

    # Format validations
    it { expect(person).to allow_value('Петрова Ольга Ивановна').for(:full_name) }
    it { expect(person).not_to allow_value('').for(:full_name) }

    it { expect(person).to allow_value('+79991112233').for(:phone_numbers) }
    it { expect(person).not_to allow_value('111222').for(:phone_numbers) }

    # Inclusion/acceptance of values
    it { expect(person).to validate_length_of(:full_name).is_at_least(1) }
    it { expect(person).to validate_length_of(:phone_numbers).is_at_least(10) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(person).to have_many(:estate).dependent(:destroy) }

    # Database columns/indexes
    it { expect(person).to have_db_column(:full_name).of_type(:string).with_options(null: false) }
    it { expect(person).to have_db_index(:full_name) }

    it { expect(person).to have_db_column(:phone_numbers).of_type(:string).with_options(null: false) }
    it { expect(person).to have_db_index(:phone_numbers) }
  end
end
