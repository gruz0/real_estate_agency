require 'rails_helper'

RSpec.describe Estate, type: :model do
  let(:estate) { build(:estate) }

  it 'has a valid factory' do
    expect(estate).to be_valid
  end

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(estate).to validate_presence_of(:deal_type).with_message(I18n.t('errors.messages.blank')) }
    it { expect(estate).to validate_presence_of(:price).with_message(I18n.t('errors.messages.blank')) }
    it { expect(estate).to validate_presence_of(:client).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:employee).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:address).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:estate_type).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:estate_project).with_message(I18n.t('errors.messages.required')) }
    it { expect(estate).to validate_presence_of(:estate_material).with_message(I18n.t('errors.messages.required')) }

    # Format validations
    it { expect(estate).to allow_value(:sale).for(:deal_type) }
    it { expect(estate).to allow_value(:rent).for(:deal_type) }

    it { expect(estate).to allow_value(:archived).for(:status) }
    it { expect(estate).to allow_value(:active).for(:status) }

    it { expect(estate).to allow_value('55').for(:apartment_number) }
    it { expect(estate).to allow_value(99_999_999).for(:price) }
    it { expect(estate).to allow_value(1).for(:price) }
    it { expect(estate).not_to allow_value(0).for(:price) }
    it { expect(estate).to allow_value(10).for(:number_of_rooms) }
    it { expect(estate).to allow_value(nil).for(:number_of_rooms) }
    it { expect(estate).to allow_value(15).for(:floor) }
    it { expect(estate).to allow_value(nil).for(:floor) }
    it { expect(estate).to allow_value(20).for(:number_of_floors) }
    it { expect(estate).to allow_value(nil).for(:number_of_floors) }
    it { expect(estate).to allow_value(100.1).for(:total_square_meters) }
    it { expect(estate).to allow_value(nil).for(:total_square_meters) }
    it { expect(estate).to allow_value(33.11).for(:kitchen_square_meters) }
    it { expect(estate).to allow_value(nil).for(:kitchen_square_meters) }

    # Inclusion/acceptance of values
    it { expect(estate).to validate_numericality_of(:price).is_greater_than(0) }
    it { expect(estate).to validate_numericality_of(:number_of_rooms).is_greater_than(0) }
    it { expect(estate).to validate_numericality_of(:floor).is_greater_than(0) }
    it { expect(estate).to validate_numericality_of(:number_of_floors).is_greater_than(0) }
    it { expect(estate).to validate_numericality_of(:total_square_meters).is_greater_than(0) }
    it { expect(estate).to validate_numericality_of(:kitchen_square_meters).is_greater_than(0) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(estate).to belong_to(:client) }
    it { expect(estate).to belong_to(:employee) }
    it { expect(estate).to belong_to(:address) }
    it { expect(estate).to belong_to(:estate_type) }
    it { expect(estate).to belong_to(:estate_project) }
    it { expect(estate).to belong_to(:estate_material) }

    # Database columns/indexes
    it { expect(estate).to have_db_column(:deal_type).of_type(:integer).with_options(null: false, default: :sale) }
    it { expect(estate).to have_db_index(:deal_type) }

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

    it { expect(estate).to have_db_column(:employee_id).of_type(:integer).with_options(null: false) }
    it { expect(estate).to have_db_index(:employee_id) }

    it { expect(estate).to have_db_column(:price).of_type(:decimal).with_options(null: false, precision: 12, scale: 2) }
    it { expect(estate).to have_db_index(:price) }

    it { expect(estate).to have_db_column(:status).of_type(:integer).with_options(null: false, default: :active) }
    it { expect(estate).to have_db_index(:status) }

    it { expect(estate).to have_db_column(:apartment_number).of_type(:string).with_options(null: true) }
    it { expect(estate).to have_db_column(:number_of_rooms).of_type(:integer).with_options(null: true) }
    it { expect(estate).to have_db_column(:floor).of_type(:integer).with_options(null: true) }
    it { expect(estate).to have_db_column(:number_of_floors).of_type(:integer).with_options(null: true) }
    it { expect(estate).to have_db_column(:total_square_meters).of_type(:float).with_options(null: true) }
    it { expect(estate).to have_db_column(:kitchen_square_meters).of_type(:float).with_options(null: true) }
    it { expect(estate).to have_db_column(:description).of_type(:string).with_options(null: true) }
  end

  describe 'public class methods' do
    describe 'responds to its methods' do
      it { expect(Estate).to respond_to(:deal_types) }
    end

    describe 'executes methods correctly' do
      describe '#deal_types' do
        it 'returns available types' do
          expect(Estate.deal_types).to eq(%i[sale rent])
        end
      end
    end
  end
end
