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

    # Inclusion/acceptance of values
    it { expect(person).to validate_length_of(:last_name).is_at_least(1) }
    it { expect(person).to validate_length_of(:first_name).is_at_least(1) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(person).to have_many(:estate).dependent(:destroy) }

    # Database columns/indexes
    it { expect(person).to have_db_column(:last_name).of_type(:string).with_options(null: false) }
    it { expect(person).to have_db_index(:last_name) }

    it { expect(person).to have_db_column(:first_name).of_type(:string).with_options(null: false) }

    it { expect(person).to have_db_column(:phone_numbers).of_type(:string).with_options(null: true) }
  end

  describe 'scopes' do
    it '.ordered_by_full_name returns employees ordered by full_name ascending' do
      employee1 = create(:employee, last_name: 'Сергеев', first_name: 'Алексей')
      employee2 = create(:employee, last_name: 'Афонин', first_name: 'Пётр')
      employee3 = create(:employee, last_name: 'Дмитриев', first_name: 'Денис')

      employees = Employee.ordered_by_full_name
      expect(employees.size).to eq(3)
      expect(employees).to eq([employee2, employee3, employee1])
    end
  end
end
