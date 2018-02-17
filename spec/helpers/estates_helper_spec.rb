require 'rails_helper'

RSpec.describe EstatesHelper, type: :helper do
  let(:client) { create(:client) }
  let(:employee) { create(:employee) }
  let(:city) { create(:city) }
  let(:street) { create(:street, city: city) }
  let(:address) { create(:address, street: street) }
  let(:estate_type) { create(:estate_type) }
  let(:estate_project) { create(:estate_project) }
  let(:estate_material) { create(:estate_material) }
  let(:estate) { create(:estate, valid_attributes) }

  let(:floor) { 3 }
  let(:number_of_floors) { 8 }
  let(:number_of_rooms) { 4 }
  let(:valid_attributes) do
    {
      client: client,
      created_by_employee: employee,
      responsible_employee: employee,
      address: address,
      estate_type: estate_type,
      estate_project: estate_project,
      estate_material: estate_material,
      price: 99_999.99,
      floor: floor,
      number_of_floors: number_of_floors,
      number_of_rooms: number_of_rooms
    }
  end

  describe '#number_of_floors_for' do
    describe 'floor and number_of_floors are set' do
      it 'concats values' do
        expect(helper.number_of_floors_for(estate)).to eq('3/8')
      end
    end

    describe 'floor is set but number_of_floors is not set' do
      let(:number_of_floors) { nil }

      it 'concats values' do
        expect(helper.number_of_floors_for(estate)).to eq("3/#{I18n.t('views.is_not_set.other')}")
      end
    end

    describe 'floor is not set but number_of_floors is set' do
      let(:floor) { nil }

      it 'concats values' do
        expect(helper.number_of_floors_for(estate)).to eq("#{I18n.t('views.is_not_set.one')}/8")
      end
    end

    describe 'floor and number_of_floors are not set' do
      let(:floor) { nil }
      let(:number_of_floors) { nil }

      it 'concats values' do
        expect(helper.number_of_floors_for(estate))
          .to eq("#{I18n.t('views.is_not_set.one')}/#{I18n.t('views.is_not_set.other')}")
      end
    end
  end

  describe '#number_of_rooms_for' do
    describe 'number_of_rooms is set' do
      it 'returns value' do
        expect(helper.number_of_rooms_for(estate)).to eq('4')
      end
    end

    describe 'number_of_rooms is not set' do
      let(:number_of_rooms) { nil }

      it 'returns is not set' do
        expect(helper.number_of_rooms_for(estate)).to eq(I18n.t('views.is_not_set.other'))
      end
    end
  end

  describe '#clickable_phones_for' do
    let(:link_format) { '<a href="tel://%<href>s">%<phone_number>s</a>' }
    let(:phone_numbers) { estate.client.phone_numbers }

    describe 'client has one phone number' do
      it 'returns value' do
        expect(helper.clickable_phones_for(estate.client))
          .to eq(format(link_format, href: phone_numbers, phone_number: phone_numbers))
      end
    end

    describe 'client has multiple phone numbers without spaces' do
      let(:client) { create(:client, phone_numbers: '+71112223344,89992224455') }

      it 'returns value' do
        expected = phone_numbers.split(',').map do |phone_number|
          format(link_format, href: phone_number, phone_number: phone_number)
        end.join(', ')

        expect(helper.clickable_phones_for(estate.client)).to eq(expected)
      end
    end

    describe 'client has multiple phone numbers with short phone number and spaces' do
      let(:client) { create(:client, phone_numbers: ' +71112223344  , 89992224455   ,111222') }

      it 'returns value' do
        expected = phone_numbers.split(',').map do |phone_number|
          format(link_format, href: phone_number, phone_number: phone_number)
        end.join(', ')

        expect(helper.clickable_phones_for(estate.client)).to eq(expected)
      end
    end
  end

  describe '#streets_depends_on_city_for(estate)' do
    let(:city) { create(:city, name: 'Нефтеюганск') }
    let(:street) { Street.create!(city: city, name: '9-й мкрн') }

    it 'returns streets ordered by name for the estate city' do
      # Create streets in the first city
      streets = [
        Street.create!(city: city, name: 'ул. Ленина'),
        Street.create!(city: city, name: 'ул. Усть-Балыкская'),
        Street.create!(city: city, name: 'ул. Объездная')
      ]

      # Create another city with streets
      other_city = create(:city, name: 'Сургут')
      Street.create!(city: other_city, name: 'ул. Нефтеюганская')
      Street.create!(city: other_city, name: 'ул. Промышленная')

      result = helper.streets_depends_on_city_for(estate)
      expect(result).to eq([street, streets[0], streets[2], streets[1]])
    end

    it 'returns streets ordered by name for the first city (ordered by name) if estate is an empty object' do
      Street.create!(city: city, name: 'ул. Ленина')

      # Create another city with streets
      other_city = create(:city, name: 'Альметьевск')
      streets = [
        Street.create!(city: other_city, name: 'ул. Первая'),
        Street.create!(city: other_city, name: 'ул. Вторая')
      ]

      result = helper.streets_depends_on_city_for(Estate.new)
      expect(result).to eq([streets[1], streets[0]])
    end
  end
end
