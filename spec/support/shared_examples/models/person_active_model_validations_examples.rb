RSpec.shared_examples :person_active_record_associations do
  # Basic validations
  it { expect(person).to validate_presence_of(:last_name).with_message(I18n.t('errors.messages.blank')) }
  it { expect(person).to validate_presence_of(:first_name).with_message(I18n.t('errors.messages.blank')) }
  it { expect(person).to validate_presence_of(:phone_numbers).with_message(I18n.t('errors.messages.blank')) }

  # Format validations
  it { expect(person).to allow_value('Петрова').for(:last_name) }
  it { expect(person).to allow_value('Ольга').for(:first_name) }
  it { expect(person).to allow_value('73335551234').for(:phone_numbers) }

  # Inclusion/acceptance of values
  it { expect(person).to validate_length_of(:last_name).is_at_least(1) }
  it { expect(person).to validate_length_of(:first_name).is_at_least(1) }
  it { expect(person).to validate_length_of(:phone_numbers).is_at_least(10) }
end
