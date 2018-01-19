RSpec.shared_examples :person_active_model_validations do
  # Database columns/indexes
  it { expect(subject).to have_db_column(:type).of_type(:string).with_options(null: false) }
  it { expect(subject).to have_db_index(:type) }

  it { expect(subject).to have_db_column(:last_name).of_type(:string).with_options(null: false) }
  it { expect(subject).to have_db_index(:last_name) }

  it { expect(subject).to have_db_column(:first_name).of_type(:string).with_options(null: false) }

  it { expect(subject).to have_db_column(:phone_numbers).of_type(:string).with_options(null: false) }
  it { expect(subject).to have_db_index(:phone_numbers) }
end
