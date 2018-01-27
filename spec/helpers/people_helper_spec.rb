require 'rails_helper'

RSpec.describe PeopleHelper, type: :helper do
  let(:person) do
    create(:person, last_name: 'Иванов', first_name: 'Пётр', middle_name: middle_name)
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
  end
end
