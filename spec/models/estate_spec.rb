require 'rails_helper'

RSpec.describe Estate, type: :model do
  it 'has a valid factory' do
    expect(build(:estate)).to be_valid
  end

  let(:subject) { build(:estate) }

  describe 'ActiveModel validations' do
    # Basic validations
    it { expect(subject).to validate_presence_of(:deal_type).with_message(I18n.t('errors.messages.blank')) }
    it { expect(subject).to validate_presence_of(:price).with_message(I18n.t('errors.messages.blank')) }
    it { expect(subject).to validate_presence_of(:client).with_message(I18n.t('errors.messages.required')) }
    it { expect(subject).to validate_presence_of(:employee).with_message(I18n.t('errors.messages.required')) }
    it { expect(subject).to validate_presence_of(:address).with_message(I18n.t('errors.messages.required')) }
    it { expect(subject).to validate_presence_of(:estate_type).with_message(I18n.t('errors.messages.required')) }
    it { expect(subject).to validate_presence_of(:estate_project).with_message(I18n.t('errors.messages.required')) }
    it { expect(subject).to validate_presence_of(:estate_material).with_message(I18n.t('errors.messages.required')) }

    # Format validations
    it { expect(subject).to allow_value(:sale).for(:deal_type) }
    it { expect(subject).to allow_value(:rent).for(:deal_type) }

    it { expect(subject).to allow_value(:archived).for(:status) }
    it { expect(subject).to allow_value(:active).for(:status) }

    it { expect(subject).to allow_value(99_999_999).for(:price) }
    it { expect(subject).to allow_value(1).for(:price) }
    it { expect(subject).not_to allow_value(0).for(:price) }

    # Inclusion/acceptance of values
    it { expect(subject).to validate_numericality_of(:price).is_greater_than(0) }
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(subject).to belong_to(:client) }
    it { expect(subject).to belong_to(:employee) }
    it { expect(subject).to belong_to(:address) }
    it { expect(subject).to belong_to(:estate_type) }
    it { expect(subject).to belong_to(:estate_project) }
    it { expect(subject).to belong_to(:estate_material) }

    # Database columns/indexes
    it { expect(subject).to have_db_column(:deal_type).of_type(:integer).with_options(null: false, default: :sale) }
    it { expect(subject).to have_db_index(:deal_type) }

    it { expect(subject).to have_db_column(:estate_type_id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_index(:estate_type_id) }

    it { expect(subject).to have_db_column(:estate_project_id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_index(:estate_project_id) }

    it { expect(subject).to have_db_column(:estate_material_id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_index(:estate_material_id) }

    it { expect(subject).to have_db_column(:address_id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_index(:address_id) }

    it { expect(subject).to have_db_column(:client_id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_index(:client_id) }

    it { expect(subject).to have_db_column(:employee_id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_index(:employee_id) }

    it { expect(subject).to have_db_column(:price).of_type(:decimal).with_options(null: false, precision: 12, scale: 2) }
    it { expect(subject).to have_db_index(:price) }

    it { expect(subject).to have_db_column(:status).of_type(:integer).with_options(null: false, default: :active) }
    it { expect(subject).to have_db_index(:status) }

    it { expect(subject).to have_db_column(:number_of_rooms).of_type(:integer).with_options(null: true) }
    it { expect(subject).to have_db_column(:floor).of_type(:integer).with_options(null: true) }
    it { expect(subject).to have_db_column(:number_of_floors).of_type(:integer).with_options(null: true) }
    it { expect(subject).to have_db_column(:total_square_meters).of_type(:float).with_options(null: true) }
    it { expect(subject).to have_db_column(:kitchen_square_meters).of_type(:float).with_options(null: true) }
    it { expect(subject).to have_db_column(:description).of_type(:string).with_options(null: true) }
  end
end
