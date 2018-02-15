require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:person) { build(:client) }

  it 'has a valid factory' do
    expect(person).to be_valid
  end

  it 'has an invalid factory' do
    person.phone_numbers = '+79991112233, 89123338444или5'
    expect(person).to be_invalid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(person).to validate_presence_of(:full_name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(person).to validate_presence_of(:phone_numbers).with_message(I18n.t('errors.messages.blank')) }

    # Format validations
    it { expect(person).to allow_value('Петрова Ольга Ивановна').for(:full_name) }
    it { expect(person).not_to allow_value('').for(:full_name) }

    it { expect(person).to allow_value('+79991112233').for(:phone_numbers) }
    it { expect(person).to allow_value('89991112233   ').for(:phone_numbers) }
    it { expect(person).to allow_value('89991112233   ,  +79991113388').for(:phone_numbers) }
    it { expect(person).to allow_value('111222').for(:phone_numbers) }
    it { expect(person).not_to allow_value('11122').for(:phone_numbers) }
    it { expect(person).not_to allow_value('8(999)1112233').for(:phone_numbers) }
    it { expect(person).not_to allow_value('8-999-111-2233').for(:phone_numbers) }
    it { expect(person).not_to allow_value('89991112233или7').for(:phone_numbers) }

    # Inclusion/acceptance of values
    it { expect(person).to validate_length_of(:full_name).is_at_least(1) }
    it { expect(person).to validate_length_of(:phone_numbers).is_at_least(6) }
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

  describe 'scopes' do
    it '.ordered_by_full_name returns clients ordered by full_name ascending' do
      client1 = create(:client, full_name: 'Иванов Сергей')
      client2 = create(:client, full_name: 'Алексеева Снежана')
      client3 = create(:client, full_name: 'Зубарева Наталья')

      clients = Client.ordered_by_full_name
      expect(clients.size).to eq(3)
      expect(clients).to eq([client2, client3, client1])
    end
  end

  describe 'before filters' do
    describe '#full_name' do
      it 'returns full_name without spaces' do
        person.full_name = '    Сергеев Алексей Петрович   '
        person.save && person.reload
        expect(person.full_name).to eq('Сергеев Алексей Петрович')
      end
    end

    describe '#phone_numbers' do
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
