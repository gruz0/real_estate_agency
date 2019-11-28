require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:person) { build(:employee) }

  it 'has a valid factory' do
    expect(person).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(person).to validate_presence_of(:last_name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(person).to validate_presence_of(:first_name).with_message(I18n.t('errors.messages.blank')) }

    # Format validations
    it { expect(person).to allow_value('Петрова').for(:last_name) }
    it { expect(person).to allow_value('Ольга').for(:first_name) }

    it { expect(person).to allow_value(:user).for(:role) }
    it { expect(person).to allow_value(:admin).for(:role) }
    it { expect(person).to allow_value(:service_admin).for(:role) }

    # Inclusion/acceptance of values
    it { expect(person).to validate_length_of(:last_name).is_at_least(1) }
    it { expect(person).to validate_length_of(:first_name).is_at_least(1) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(person).to have_many(:estate).dependent(:restrict_with_error) }

    # Database columns/indexes
    it { expect(person).to have_db_column(:last_name).of_type(:string).with_options(null: false) }
    it { expect(person).to have_db_index(:last_name) }

    it { expect(person).to have_db_column(:first_name).of_type(:string).with_options(null: false) }
    it { expect(person).to have_db_column(:phone_numbers).of_type(:string).with_options(null: true) }
    it { expect(person).to have_db_column(:role).of_type(:integer).with_options(null: false, default: :user) }
  end

  describe 'modify attributes' do
    describe '#last_name' do
      it 'returns last_name without spaces' do
        person.last_name = '    Иванов     '
        expect(person.last_name).to eq('Иванов')
      end

      it 'returns last_name titleized' do
        person.last_name = 'иванов'
        expect(person.last_name).to eq('Иванов')
      end

      it 'returns last_name titleized if last_name contains two names' do
        person.last_name = 'иванова-петрова'
        expect(person.last_name).to eq('Иванова-Петрова')
      end
    end

    describe '#first_name' do
      it 'returns first_name without spaces' do
        person.first_name = '    Пётр     '
        expect(person.first_name).to eq('Пётр')
      end

      it 'returns first_name titleized' do
        person.first_name = 'алексей'
        expect(person.first_name).to eq('Алексей')
      end
    end

    describe '#middle_name' do
      it 'returns middle_name without spaces' do
        person.middle_name = '    Сергеевич     '
        expect(person.middle_name).to eq('Сергеевич')
      end

      it 'returns middle_name titleized' do
        person.middle_name = 'николаевич'
        expect(person.middle_name).to eq('Николаевич')
      end
    end
  end

  describe 'callbacks' do
    it { expect(person).to callback(:prevent_to_destroy_last_employee).before(:destroy) }

    describe '#prevent_to_destroy_last_employee' do
      it 'has error for :last_employee attribute' do
        last_employee = create(:employee)
        last_employee.destroy

        expect(last_employee.errors[:last_employee])
          .to include(I18n.t('activerecord.errors.messages.unable_to_be_destroyed'))
      end
    end
  end

  describe 'scopes' do
    it '.ordered_by_full_name returns employees ordered by full_name ascending' do
      employee1 = create(:employee, last_name: 'Сергеев', first_name: 'Алексей')
      employee2 = create(:employee, last_name: 'Афонин', first_name: 'Пётр')
      employee3 = create(:employee, last_name: 'Дмитриев', first_name: 'Денис')

      employees = described_class.ordered_by_full_name
      expect(employees.size).to eq(3)
      expect(employees).to eq([employee2, employee3, employee1])
    end
  end
end
