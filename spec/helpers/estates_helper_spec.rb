# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EstatesHelper, type: :helper do
  let(:employee) { create(:employee) }
  let(:city) { create(:city, name: 'Нефтеюганск') }
  let(:street) { create(:street, city: city, name: 'ул. Ленина') }
  let(:address) { create(:address, street: street, building_number: '13') }
  let(:estate_type) { create(:estate_type) }
  let(:estate_project) { create(:estate_project) }
  let(:estate_material) { create(:estate_material) }
  let(:estate) { create(:estate, valid_attributes) }

  let(:floor) { 3 }
  let(:number_of_floors) { 8 }
  let(:number_of_rooms) { 4 }
  let(:apartment_number) { 55 }
  let(:valid_attributes) do
    {
      created_by_employee: employee,
      responsible_employee: employee,
      address: address,
      apartment_number: apartment_number,
      estate_type: estate_type,
      estate_project: estate_project,
      estate_material: estate_material,
      client_full_name: 'Иванова Наталья Петровна',
      client_phone_numbers: '+79991112233',
      price: 99_999,
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

    describe 'client has one phone number' do
      let(:phone_numbers) { '223344' }

      it 'returns value' do
        expect(helper.clickable_phones_for(phone_numbers))
          .to eq(format(link_format, href: phone_numbers, phone_number: phone_numbers))
      end
    end

    describe 'client has multiple phone numbers without spaces' do
      let(:phone_numbers) { '+71112223344,89992224455' }

      it 'returns value' do
        expected = phone_numbers.split(',').map do |phone_number|
          format(link_format, href: phone_number, phone_number: phone_number)
        end.join(', ')

        expect(helper.clickable_phones_for(phone_numbers)).to eq(expected)
      end
    end

    describe 'client has multiple phone numbers with short phone number and spaces' do
      let(:phone_numbers) { ' +71112223344  , 89992224455   ,111222' }

      it 'returns value' do
        expected = phone_numbers.split(',').map(&:strip).map do |phone_number|
          format(link_format, href: phone_number, phone_number: phone_number)
        end.join(', ')

        expect(helper.clickable_phones_for(phone_numbers)).to eq(expected)
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

  describe '#format_price' do
    it 'returns formatted price' do
      expect(helper.format_price(1234)).to eq('1 234 000')
    end
  end

  describe '#address_full_name_for' do
    context 'with apartment_number' do
      it 'returns address full name with building number and apartment number' do
        expect(helper.address_full_name_for(estate)).to eq('Нефтеюганск, ул. Ленина, 13, 55')
      end
    end

    context 'without apartment_number' do
      let(:apartment_number) { nil }

      it 'returns address full name only with building number' do
        expect(helper.address_full_name_for(estate)).to eq('Нефтеюганск, ул. Ленина, 13')
      end
    end
  end

  describe '#delayed_until' do
    context 'when estate delayed' do
      let(:delayed_until) { Date.current + 3.days }

      it 'returns html' do
        estate.update(status: :delayed, delayed_until: delayed_until)

        expect(helper.delayed_until(estate.reload)).to eq(
          '<div class="row col-lg-10"><div class="alert alert-secondary">' +
          I18n.t('views.estate.show.delayed_until', delayed_until: delayed_until.strftime('%Y-%m-%d')) +
          '</div></div>'
        )
      end
    end

    context 'when estate is not delayed' do
      it 'returns nothing' do
        expect(helper.delayed_until(estate)).to be_nil
      end
    end
  end

  describe '#cancel_delay' do
    context 'when estate delayed' do
      it 'returns html' do
        estate.update(status: :delayed, delayed_until: Date.current + 3.days)

        expect(helper.cancel_delay(estate.reload)).to eq(
          '<form action="' + cancel_delay_estate_path(estate) + '" accept-charset="UTF-8" method="post">' \
          '<input name="utf8" type="hidden" value="&#x2713;" />' \
          '<input type="hidden" name="_method" value="delete" />' \
          '<hr />' \
          '<input type="submit" name="commit" value="' + I18n.t('helpers.submit.cancel_delay') +
          '" class="btn btn-warning" data-disable-with="' + I18n.t('helpers.submit.update') + '" />' \
          '</form>'
        )
      end
    end

    context 'when estate is not delayed' do
      it 'returns nothing' do
        expect(helper.cancel_delay(estate)).to be_nil
      end
    end
  end

  describe '#add_classes_to_estate_row' do
    context 'when estate delayed' do
      it 'returns table-secondary class' do
        estate.update(status: :delayed, delayed_until: Date.current + 3.days)

        expect(helper.add_classes_to_estate_row(estate.reload)).to eq('table-secondary')
      end
    end

    context 'when estate is not delayed' do
      it 'returns row without classes' do
        expect(helper.add_classes_to_estate_row(estate)).to be_nil
      end
    end
  end
end
