require 'rails_helper'

RSpec.describe Estate, type: :model do
  let(:estate) { build(:estate) }

  it 'has a valid factory' do
    expect(estate).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(estate).to validate_presence_of(:price).with_message(I18n.t('errors.messages.blank')) }
    it { expect(estate).to validate_presence_of(:client).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:responsible_employee).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:created_by_employee).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:address).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:estate_type).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:estate_project).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:estate_material).with_message(I18n.t('errors.messages.required')) }

    # Format validations
    it { expect(estate).to allow_value(:archived).for(:status) }
    it { expect(estate).to allow_value(:active).for(:status) }

    it { expect(estate).not_to allow_value(nil).for(:client) }
    it { expect(estate).not_to allow_value(nil).for(:responsible_employee) }
    it { expect(estate).not_to allow_value(nil).for(:created_by_employee) }
    it { expect(estate).to allow_value(nil).for(:updated_by_employee) }
    it { expect(estate).not_to allow_value(nil).for(:address) }
    it { expect(estate).not_to allow_value(nil).for(:estate_type) }
    it { expect(estate).not_to allow_value(nil).for(:estate_project) }
    it { expect(estate).not_to allow_value(nil).for(:estate_material) }

    it { expect(estate).to allow_value('55').for(:apartment_number) }

    it { expect(estate).to allow_value(99_999).for(:price) }
    it { expect(estate).to allow_value(1).for(:price) }
    it { expect(estate).not_to allow_value(100_000).for(:price) }
    it { expect(estate).not_to allow_value(0).for(:price) }
    it { expect(estate).not_to allow_value('qwe').for(:price) }

    it { expect(estate).to allow_value(9).for(:number_of_rooms) }
    it { expect(estate).to allow_value(nil).for(:number_of_rooms) }
    it { expect(estate).not_to allow_value(10).for(:number_of_rooms) }
    it { expect(estate).not_to allow_value('qwe').for(:number_of_rooms) }

    it { expect(estate).to allow_value(15).for(:floor) }
    it { expect(estate).to allow_value(nil).for(:floor) }
    it { expect(estate).not_to allow_value(100).for(:floor) }
    it { expect(estate).not_to allow_value('qwe').for(:floor) }

    it { expect(estate).to allow_value(20).for(:number_of_floors) }
    it { expect(estate).to allow_value(nil).for(:number_of_floors) }
    it { expect(estate).not_to allow_value(1_000).for(:number_of_floors) }
    it { expect(estate).not_to allow_value('qwe').for(:number_of_floors) }

    it { expect(estate).to allow_value(100.1).for(:total_square_meters) }
    it { expect(estate).to allow_value(nil).for(:total_square_meters) }
    it { expect(estate).not_to allow_value('qwe').for(:total_square_meters) }

    it { expect(estate).to allow_value(33.11).for(:kitchen_square_meters) }
    it { expect(estate).to allow_value(nil).for(:kitchen_square_meters) }
    it { expect(estate).not_to allow_value('qwe').for(:kitchen_square_meters) }

    # Inclusion/acceptance of values
    it { expect(estate).to validate_numericality_of(:price).is_greater_than(0).is_less_than(100_000) }
    it { expect(estate).to validate_numericality_of(:number_of_rooms).is_greater_than(0).is_less_than(10) }
    it { expect(estate).to validate_numericality_of(:floor).is_greater_than(0).is_less_than(100) }
    it { expect(estate).to validate_numericality_of(:number_of_floors).is_greater_than(0).is_less_than(100) }
    it { expect(estate).to validate_numericality_of(:total_square_meters).is_greater_than(0).is_less_than(1000) }
    it { expect(estate).to validate_numericality_of(:kitchen_square_meters).is_greater_than(0).is_less_than(1000) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(estate).to belong_to(:client) }
    it { expect(estate).to belong_to(:responsible_employee).class_name('Employee').with_foreign_key(:responsible_employee_id) }
    it { expect(estate).to belong_to(:created_by_employee).class_name('Employee').with_foreign_key(:created_by_employee_id) }
    it { expect(estate).to belong_to(:updated_by_employee).class_name('Employee').with_foreign_key(:updated_by_employee_id) }
    it { expect(estate).to belong_to(:address) }
    it { expect(estate).to belong_to(:estate_type) }
    it { expect(estate).to belong_to(:estate_project) }
    it { expect(estate).to belong_to(:estate_material) }

    # Database columns/indexes
    it { expect(estate).to have_db_column(:estate_type_id).of_type(:integer).with_options(null: false) }
    it { expect(estate).to have_db_index(:estate_type_id) }

    it { expect(estate).to have_db_column(:estate_project_id).of_type(:integer).with_options(null: false) }
    it { expect(estate).to have_db_index(:estate_project_id) }

    it { expect(estate).to have_db_column(:estate_material_id).of_type(:integer).with_options(null: false) }
    it { expect(estate).to have_db_index(:estate_material_id) }

    it { expect(estate).to have_db_column(:address_id).of_type(:integer).with_options(null: false) }
    it { expect(estate).to have_db_index(:address_id) }

    it { expect(estate).to have_db_column(:client_id).of_type(:integer).with_options(null: false) }
    it { expect(estate).to have_db_index(:client_id) }

    it { expect(estate).to have_db_column(:responsible_employee_id).of_type(:integer).with_options(null: false) }
    it { expect(estate).to have_db_index(:responsible_employee_id) }

    it { expect(estate).to have_db_column(:created_by_employee_id).of_type(:integer).with_options(null: false) }
    it { expect(estate).to have_db_index(:created_by_employee_id) }

    it { expect(estate).to have_db_column(:updated_by_employee_id).of_type(:integer).with_options(null: true) }
    it { expect(estate).to have_db_index(:updated_by_employee_id) }

    it { expect(estate).to have_db_column(:price).of_type(:integer).with_options(null: false) }
    it { expect(estate).to have_db_index(:price) }

    it { expect(estate).to have_db_column(:status).of_type(:integer).with_options(null: false, default: :active) }
    it { expect(estate).to have_db_index(:status) }

    it { expect(estate).to have_db_column(:apartment_number).of_type(:string).with_options(null: true) }
    it { expect(estate).to have_db_column(:number_of_rooms).of_type(:integer).with_options(null: true) }
    it { expect(estate).to have_db_column(:floor).of_type(:integer).with_options(null: true) }
    it { expect(estate).to have_db_column(:number_of_floors).of_type(:integer).with_options(null: true) }
    it { expect(estate).to have_db_column(:total_square_meters).of_type(:float).with_options(null: true) }
    it { expect(estate).to have_db_column(:kitchen_square_meters).of_type(:float).with_options(null: true) }
    it { expect(estate).to have_db_column(:description).of_type(:text).with_options(null: true) }
  end

  describe 'strip attributes' do
    describe '#description' do
      it 'returns description without spaces' do
        estate.description = "    \nКакая-то\nмногострочная\nописаловка\n     "
        expect(estate.description).to eq("Какая-то\nмногострочная\nописаловка")
      end
    end
  end

  describe 'public instance methods' do
    describe 'responds to its methods' do
      it { expect(estate).to respond_to(:building_number) }
      it { expect(estate).to respond_to(:estate_type_name) }
      it { expect(estate).to respond_to(:estate_project_name) }
      it { expect(estate).to respond_to(:estate_material_name) }
      it { expect(estate).to respond_to(:client_full_name) }
      it { expect(estate).to respond_to(:client_phone_numbers) }
    end

    describe 'executes methods correctly' do
      describe '#building_number' do
        it 'returns Address building number' do
          expect(estate.building_number).to eq(estate.address.building_number)
        end
      end

      describe '#estate_type_name' do
        it 'returns EstateType name' do
          expect(estate.estate_type_name).to eq(estate.estate_type.name)
        end
      end

      describe '#estate_project_name' do
        it 'returns EstateProject name' do
          expect(estate.estate_project_name).to eq(estate.estate_project.name)
        end
      end

      describe '#estate_material_name' do
        it 'returns EstateMaterial name' do
          expect(estate.estate_material_name).to eq(estate.estate_material.name)
        end
      end

      describe '#client_full_name' do
        it 'returns Client full name' do
          expect(estate.client_full_name).to eq(estate.client.full_name)
        end
      end

      describe '#client_phone_numbers' do
        it 'returns Client phone numbers' do
          expect(estate.client_phone_numbers).to eq(estate.client.phone_numbers)
        end
      end
    end
  end
end
