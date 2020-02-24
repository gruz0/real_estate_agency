# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Competitor, type: :model do
  let(:person) { build(:competitor) }

  it 'has a valid factory' do
    expect(person).to be_valid
  end

  it 'has an invalid factory' do
    person.phone_numbers = '+79991112233, 89123338444или5'
    expect(person).to be_invalid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(person).to validate_presence_of(:phone_numbers).with_message(I18n.t('errors.messages.blank')) }

    # Format validations
    it { expect(person).to allow_value(nil).for(:name) }

    it { expect(person).to allow_value('+79991112233').for(:phone_numbers) }
    it { expect(person).to allow_value('89991112233   ').for(:phone_numbers) }
    it { expect(person).to allow_value('89991112233   ,  +79991113388').for(:phone_numbers) }
    it { expect(person).to allow_value('111222').for(:phone_numbers) }
    it { expect(person).not_to allow_value('11122').for(:phone_numbers) }
    it { expect(person).not_to allow_value('8(999)1112233').for(:phone_numbers) }
    it { expect(person).not_to allow_value('8-999-111-2233').for(:phone_numbers) }
    it { expect(person).not_to allow_value('89991112233или7').for(:phone_numbers) }

    # Inclusion/acceptance of values
    it { expect(person).to validate_length_of(:phone_numbers).is_at_least(6) }
  end

  describe 'ActiveRecord associations' do
    # Database columns/indexes
    it { expect(person).to have_db_column(:name).of_type(:string).with_options(null: true) }
    it { expect(person).to have_db_index(:name) }

    it { expect(person).to have_db_column(:phone_numbers).of_type(:string).with_options(null: false) }
    it { expect(person).to have_db_index(:phone_numbers) }
  end

  describe 'modify attributes' do
    describe '#name' do
      it 'returns name without spaces' do
        person.name = '    Николаев Максим Алексеевич     '
        expect(person.name).to eq('Николаев Максим Алексеевич')
      end

      it 'returns name titleized' do
        person.name = 'иванов-петров сергей алексеевич'
        expect(person.name).to eq('Иванов-Петров Сергей Алексеевич')
      end

      it 'returns empty string if name contains only spaces' do
        person.name = '               '
        expect(person.name).to be_empty
      end

      it 'returns empty string if name is not present' do
        person.name = nil
        expect(person.name).to be_empty
      end
    end
  end

  describe 'before filters' do
    describe '.clear_phone_numbers' do
      it 'returns valid full phone number' do
        person.phone_numbers = '+79991112233'
        person.save && person.reload
        expect(person.phone_numbers).to eq('+79991112233')
      end

      it 'returns valid short phone number' do
        person.phone_numbers = '111222'
        person.save && person.reload
        expect(person.phone_numbers).to eq('111222')
      end

      it 'returns valid phone number without spaces' do
        person.phone_numbers = '  +79991112233   '
        person.save && person.reload
        expect(person.phone_numbers).to eq('+79991112233')
      end

      it 'returns valid multiple phone numbers without spaces' do
        person.phone_numbers = '  +79991112233 , 89191911111  '
        person.save && person.reload
        expect(person.phone_numbers).to eq('+79991112233,89191911111')
      end
    end
  end
end
