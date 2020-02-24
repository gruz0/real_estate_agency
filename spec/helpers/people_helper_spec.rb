require 'rails_helper'

RSpec.describe PeopleHelper, type: :helper do
  let(:person) do
    create(:employee, last_name: 'Иванов', first_name: 'Пётр', middle_name: middle_name)
  end
  let(:middle_name) { 'Сергеевич' }

  describe '#person_fullname' do
    describe 'all attributes are set' do
      it 'concats values' do
        expect(helper.person_fullname(person)).to eq('Иванов Пётр Сергеевич')
      end
    end

    describe 'middle_name is not set' do
      let(:middle_name) { nil }

      it 'concats values' do
        expect(helper.person_fullname(person)).to eq('Иванов Пётр')
      end
    end

    describe 'person is not set' do
      let(:person) { nil }

      it 'returns empty string' do
        expect(helper.person_fullname(person)).to eq('')
      end
    end

    context 'when employee is locked' do
      before { person.lock_access! }

      it 'returns locked text' do
        expect(helper.person_fullname(person)).to eq('Иванов Пётр Сергеевич (Заблокирован)')
      end
    end
  end

  describe '#person_shortname' do
    describe 'all attributes are set' do
      it 'concats values' do
        expect(helper.person_shortname(person)).to eq('Иванов П.С.')
      end
    end

    describe 'middle_name is not set' do
      let(:middle_name) { nil }

      it 'concats values' do
        expect(helper.person_shortname(person)).to eq('Иванов П.')
      end
    end

    describe 'person is not set' do
      let(:person) { nil }

      it 'returns empty string' do
        expect(helper.person_shortname(person)).to eq('')
      end
    end

    context 'when employee is locked' do
      before { person.lock_access! }

      it 'returns locked text' do
        expect(helper.person_shortname(person)).to eq('Иванов П.С. (Заблокирован)')
      end
    end
  end
end
