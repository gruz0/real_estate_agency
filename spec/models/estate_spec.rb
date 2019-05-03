require 'rails_helper'

RSpec.describe Estate, type: :model do
  let(:estate) { build(:estate) }
  let(:employee) { create(:employee) }

  it 'has a valid factory' do
    expect(estate).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(estate).to validate_presence_of(:price).with_message(I18n.t('errors.messages.blank')) }
    it { expect(estate).to validate_presence_of(:client_full_name).with_message(I18n.t('errors.messages.blank')) }
    it { expect(estate).to validate_presence_of(:client_phone_numbers).with_message(I18n.t('errors.messages.blank')) }
    it { expect(estate).to validate_presence_of(:responsible_employee).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:created_by_employee).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:address).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:estate_type).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:estate_project).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:estate_material).with_message(I18n.t('errors.messages.required')) }

    # Format validations
    it { expect(estate).to allow_value(:archived).for(:status) }
    it { expect(estate).to allow_value(:active).for(:status) }
    it { expect(estate).to allow_value(:delayed).for(:status) }

    it { expect(estate).not_to allow_value(nil).for(:responsible_employee) }
    it { expect(estate).not_to allow_value(nil).for(:created_by_employee) }
    it { expect(estate).to allow_value(nil).for(:updated_by_employee) }
    it { expect(estate).not_to allow_value(nil).for(:address) }
    it { expect(estate).not_to allow_value(nil).for(:estate_type) }
    it { expect(estate).not_to allow_value(nil).for(:estate_project) }
    it { expect(estate).not_to allow_value(nil).for(:estate_material) }

    it { expect(estate).to allow_value('Петрова Ольга Ивановна').for(:client_full_name) }
    it { expect(estate).not_to allow_value('').for(:client_full_name) }

    it { expect(estate).to allow_value('+79991112233').for(:client_phone_numbers) }
    it { expect(estate).to allow_value('89991112233   ').for(:client_phone_numbers) }
    it { expect(estate).to allow_value('89991112233   ,  +79991113388').for(:client_phone_numbers) }
    it { expect(estate).to allow_value('111222').for(:client_phone_numbers) }
    it { expect(estate).not_to allow_value('11122').for(:client_phone_numbers) }
    it { expect(estate).not_to allow_value('8(999)1112233').for(:client_phone_numbers) }
    it { expect(estate).not_to allow_value('8-999-111-2233').for(:client_phone_numbers) }
    it { expect(estate).not_to allow_value('89991112233или7').for(:client_phone_numbers) }

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

    it { expect(estate).to allow_value(nil).for(:delayed_until) }
    it { expect(estate).to allow_value(Date.current + 2.days).for(:delayed_until) }
    it { expect(estate).not_to allow_value('').for(:delayed_until) }
    it { expect(estate).not_to allow_value(Date.current).for(:delayed_until) }
    it { expect(estate).not_to allow_value('qwe').for(:delayed_until) }

    # Inclusion/acceptance of values
    it { expect(estate).to validate_length_of(:client_full_name).is_at_least(1) }
    it { expect(estate).to validate_length_of(:client_phone_numbers).is_at_least(6) }
    it { expect(estate).to validate_numericality_of(:price).is_greater_than(0).is_less_than(100_000) }
    it { expect(estate).to validate_numericality_of(:number_of_rooms).is_greater_than(0).is_less_than(10) }
    it { expect(estate).to validate_numericality_of(:floor).is_greater_than(0).is_less_than(100) }
    it { expect(estate).to validate_numericality_of(:number_of_floors).is_greater_than(0).is_less_than(100) }
    it { expect(estate).to validate_numericality_of(:total_square_meters).is_greater_than(0).is_less_than(1000) }
    it { expect(estate).to validate_numericality_of(:kitchen_square_meters).is_greater_than(0).is_less_than(1000) }
  end

  describe 'custom validations' do
    describe '#estate_saveable?' do
      context 'when apartment_number is not present' do
        context 'when client phone numbers are unique' do
          it 'returns valid object' do
            expect(estate).to be_valid
          end
        end

        context 'when try to save estate' do
          it 'will not returns the error' do
            estate.save

            expect(estate).to be_valid
            expect(estate.errors[:base]).not_to \
              include(I18n.t('activerecord.errors.messages.client_phone_numbers_at_this_building_number_already_exist'))
          end
        end

        context 'when client phone numbers are not unique' do
          let(:another_estate) { create(:estate) }
          let(:estate) do
            build(:estate, address: another_estate.address, client_phone_numbers: another_estate.client_phone_numbers)
          end

          it 'returns validation error' do
            expect(estate).to be_invalid
            expect(estate.errors.full_messages).to include(
              I18n.t('activerecord.errors.messages.client_phone_numbers_at_this_building_number_already_exist'))
          end
        end
      end

      context 'when apartment_number is present' do
        let(:apartment_number) { '123а' }
        let(:estate) { build(:estate, apartment_number: apartment_number) }

        context 'when apartment_number is unique' do
          it 'returns valid object' do
            expect(estate).to be_valid
          end
        end

        context 'when apartment_number is not unique' do
          context 'when another estate already has this apartment number' do
            let(:another_estate) { create(:estate, apartment_number: apartment_number) }
            let(:estate) { build(:estate, address: another_estate.address, apartment_number: apartment_number) }

            it 'returns validation error' do
              expect(estate).to be_invalid
              expect(estate.errors.full_messages)
                .to include(I18n.t('activerecord.errors.messages.estate_at_this_address_already_exists'))
            end
          end

          context 'when apartment number was not changed' do
            let(:estate) { create(:estate, apartment_number: '123') }

            it 'returns valid object' do
              estate.update_attributes!(apartment_number: '123')
              expect(estate).to be_valid
            end
          end
        end
      end
    end
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(estate).not_to belong_to(:client) }
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

    it { expect(estate).to have_db_column(:client_full_name).of_type(:string).with_options(null: false) }
    it { expect(estate).to have_db_column(:client_phone_numbers).of_type(:string).with_options(null: false) }
    it { expect(estate).to have_db_column(:apartment_number).of_type(:string).with_options(null: true) }
    it { expect(estate).to have_db_column(:number_of_rooms).of_type(:integer).with_options(null: true) }
    it { expect(estate).to have_db_column(:floor).of_type(:integer).with_options(null: true) }
    it { expect(estate).to have_db_column(:number_of_floors).of_type(:integer).with_options(null: true) }
    it { expect(estate).to have_db_column(:total_square_meters).of_type(:float).with_options(null: true) }
    it { expect(estate).to have_db_column(:kitchen_square_meters).of_type(:float).with_options(null: true) }
    it { expect(estate).to have_db_column(:description).of_type(:text).with_options(null: true) }
    it { expect(estate).to have_db_column(:delayed_until).of_type(:date).with_options(null: true) }
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
      it { expect(estate).to respond_to(:created_by?) }
      it { expect(estate).to respond_to(:assigned_to?) }
      it { expect(estate).to respond_to(:delay) }
      it { expect(estate).to respond_to(:cancel_delay) }
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

      describe '#created_by?' do
        let(:saved_estate) do
          estate.update_attributes!(created_by_employee: employee)
          estate.reload
        end

        context 'when argument equals to created_by_employee' do
          it 'returns true' do
            expect(saved_estate.created_by?(employee)).to eq(true)
          end
        end

        context 'when argument equals to another employee' do
          it 'returns false' do
            expect(saved_estate.created_by?(create(:employee))).to eq(false)
          end
        end
      end

      describe '#assigned_to?' do
        let(:saved_estate) do
          estate.update_attributes!(responsible_employee: employee)
          estate.reload
        end

        context 'when argument equals to responsible_employee' do
          it 'returns true' do
            expect(saved_estate.assigned_to?(employee)).to eq(true)
          end
        end

        context 'when argument equals to another employee' do
          it 'returns false' do
            expect(saved_estate.assigned_to?(create(:employee))).to eq(false)
          end
        end
      end

      describe '#delay' do
        context 'when value is valid' do
          subject(:result) do
            estate.delay(employee: employee, delayed_until: delayed_until)
            estate.reload
          end

          let(:delayed_until) { Date.current + 2.days }

          it 'changes status to delayed' do
            expect(subject.delayed?).to eq(true)
          end

          it 'updates delayed_until column' do
            expect(subject.delayed_until.to_s).to eq(delayed_until.to_s)
          end

          it 'updates updated_at column' do
            expect { subject }.to change(estate, :updated_at)
          end

          it 'updates updated_by_employee column' do
            expect { subject }.to change(estate, :updated_by_employee).to(employee)
          end
        end

        context 'when value is empty' do
          let(:delayed_until) { '' }

          before do
            estate.delay(employee: employee, delayed_until: delayed_until)
          end

          it 'is invalid' do
            expect(estate).not_to be_valid
          end

          it 'has error' do
            expect(estate.errors.messages).to have_key(:delayed_until)
            # FIXME: It should be replaced with locale
            expect(estate.errors.messages[:delayed_until]).to eq(['некорректная дата'])
          end
        end

        context 'when value is not a valid datetime' do
          let(:delayed_until) { 'qwe' }

          before do
            estate.delay(employee: employee, delayed_until: delayed_until)
          end

          it 'is invalid' do
            expect(estate).not_to be_valid
          end

          it 'has error' do
            expect(estate.errors.messages).to have_key(:delayed_until)
            # FIXME: It should be replaced with locale
            expect(estate.errors.messages[:delayed_until]).to eq(['некорректная дата'])
          end
        end

        context 'when value is not greater than now' do
          let(:delayed_until) { Date.current }

          before do
            estate.delay(employee: employee, delayed_until: delayed_until)
          end

          it 'is invalid' do
            expect(estate).not_to be_valid
          end

          it 'has error' do
            expect(estate.errors.messages).to have_key(:delayed_until)
            # FIXME: It should be replaced with locale
            expect(estate.errors.messages[:delayed_until]).to eq(["должно быть после #{Date.current} 00:00:00"])
          end
        end
      end

      describe '#cancel_delay' do
        subject(:result) do
          estate.cancel_delay(employee: employee)
          estate.reload
        end

        it 'changes status to active' do
          expect(subject.active?).to eq(true)
        end

        it 'updates delayed_until column' do
          expect(subject.delayed_until).to be_nil
        end

        it 'updates updated_at column' do
          expect { subject }.to change(estate, :updated_at)
        end

        it 'updates updated_by_employee column' do
          expect { subject }.to change(estate, :updated_by_employee).to(employee)
        end
      end
    end
  end
end
