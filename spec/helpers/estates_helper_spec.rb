# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EstatesHelper, type: :helper do
  subject(:estate) { build(:estate) }

  describe '#number_of_floors_for' do
    subject(:number_of_floors) { helper.number_of_floors_for(estate) }

    describe 'floor and number_of_floors are set' do
      before do
        estate.floor = 3
        estate.number_of_floors = 8
      end

      it 'concats values' do
        expect(number_of_floors).to eq('3/8')
      end
    end

    describe 'floor is set but number_of_floors is not set' do
      before do
        estate.floor = 3
        estate.number_of_floors = nil
      end

      it 'concats values' do
        expect(number_of_floors).to eq("3/#{I18n.t('views.is_not_set.other')}")
      end
    end

    describe 'floor is not set but number_of_floors is set' do
      before do
        estate.floor = nil
        estate.number_of_floors = 8
      end

      it 'concats values' do
        expect(number_of_floors).to eq("#{I18n.t('views.is_not_set.one')}/8")
      end
    end

    describe 'floor and number_of_floors are not set' do
      before do
        estate.floor = nil
        estate.number_of_floors = nil
      end

      it 'concats values' do
        expect(number_of_floors).to eq("#{I18n.t('views.is_not_set.one')}/#{I18n.t('views.is_not_set.other')}")
      end
    end
  end

  describe '#number_of_rooms_for' do
    subject(:number_of_rooms) { helper.number_of_rooms_for(estate) }

    describe 'number_of_rooms is set' do
      before { estate.number_of_rooms = 4 }

      it 'returns value' do
        expect(number_of_rooms).to eq('4')
      end
    end

    describe 'number_of_rooms is not set' do
      before { estate.number_of_rooms = nil }

      it 'returns is not set' do
        expect(number_of_rooms).to eq(I18n.t('views.is_not_set.other'))
      end
    end
  end

  describe '#clickable_phones_for' do
    subject(:clickable_phones) { helper.clickable_phones_for(phone_numbers) }

    let(:link_format) { '<a href="tel://%<href>s">%<phone_number>s</a>' }

    describe 'client has one phone number' do
      let(:phone_numbers) { '223344' }

      it 'returns value' do
        expect(clickable_phones)
          .to eq(format(link_format, href: phone_numbers, phone_number: phone_numbers))
      end
    end

    describe 'client has multiple phone numbers without spaces' do
      let(:phone_numbers) { '+71112223344,89992224455' }

      it 'returns value' do
        expected = phone_numbers.split(',').map do |phone_number|
          format(link_format, href: phone_number, phone_number: phone_number)
        end.join(', ')

        expect(clickable_phones).to eq(expected)
      end
    end

    describe 'client has multiple phone numbers with short phone number and spaces' do
      let(:phone_numbers) { ' +71112223344  , 89992224455   ,111222' }

      it 'returns value' do
        expected = phone_numbers.split(',').map(&:strip).map do |phone_number|
          format(link_format, href: phone_number, phone_number: phone_number)
        end.join(', ')

        expect(clickable_phones).to eq(expected)
      end
    end
  end

  describe '#streets_depends_on_city_for(estate)' do
    it 'returns streets ordered by name for the estate city' do
      city = create(:city, name: 'Нефтеюганск')
      street = create(:street, city: city, name: '9-й мкрн')

      estate.address.street.city = city

      # Create streets in the first city
      streets = [
        create(:street, city: city, name: 'ул. Ленина'),
        create(:street, city: city, name: 'ул. Усть-Балыкская'),
        create(:street, city: city, name: 'ул. Объездная')
      ]

      # Create another city with streets
      other_city = create(:city, name: 'Сургут')
      create(:street, city: other_city, name: 'ул. Нефтеюганская')
      create(:street, city: other_city, name: 'ул. Промышленная')

      result = helper.streets_depends_on_city_for(estate)
      expect(result).to eq([street, streets[0], streets[2], streets[1]])
    end

    it 'returns streets ordered by name for the first city (ordered by name) if estate is an empty object' do
      city = create(:city, name: 'Нефтеюганск')
      create(:street, city: city, name: 'ул. Ленина')

      # Create another city with streets
      other_city = create(:city, name: 'Альметьевск')
      streets = [
        create(:street, city: other_city, name: 'ул. Первая'),
        create(:street, city: other_city, name: 'ул. Вторая')
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
    subject(:address_full_name) { helper.address_full_name_for(estate) }

    before do
      city = build(:city, name: 'Нефтеюганск')
      street = build(:street, city: city, name: 'ул. Ленина')
      address = build(:address, street: street, building_number: '13')

      estate.address = address
    end

    context 'with apartment_number' do
      before { estate.apartment_number = 55 }

      it 'returns address full name with building number and apartment number' do
        expect(address_full_name).to eq('Нефтеюганск, ул. Ленина, 13, 55')
      end
    end

    context 'without apartment_number' do
      before { estate.apartment_number = nil }

      it 'returns address full name only with building number' do
        expect(address_full_name).to eq('Нефтеюганск, ул. Ленина, 13')
      end
    end
  end

  describe '#delayed_until' do
    subject(:html) { helper.delayed_until(estate) }

    it { is_expected.to be_nil }

    context 'when estate delayed' do
      let(:delayed_until) { Date.current + 3.days }

      before do
        estate.status = :delayed
        estate.delayed_until = delayed_until
      end

      it 'returns html' do
        expect(html).to eq(
          '<div class="row col-lg-10"><div class="alert alert-secondary">' \
          "#{I18n.t('views.estate.show.delayed_until', delayed_until: delayed_until.strftime('%Y-%m-%d'))}" \
          '</div></div>'
        )
      end
    end
  end

  describe '#cancel_delay' do
    subject(:html) { helper.cancel_delay(estate) }

    it { is_expected.to be_nil }

    context 'when estate delayed' do
      before do
        estate.status = :delayed
        estate.delayed_until = Date.current + 3.days
        estate.save
      end

      it 'returns html' do
        path = cancel_delay_estate_path(estate)
        cancel_delay_label = I18n.t('helpers.submit.cancel_delay')
        update_label = I18n.t('helpers.submit.update')

        expect(html).to eq(
          "<form action=\"#{path}\" accept-charset=\"UTF-8\" method=\"post\">" \
          '<input name="utf8" type="hidden" value="&#x2713;" />' \
          '<input type="hidden" name="_method" value="delete" />' \
          '<hr />' \
          "<input type=\"submit\" name=\"commit\" value=\"#{cancel_delay_label}\" class=\"btn btn-warning\" " \
          "data-disable-with=\"#{update_label}\" />" \
          '</form>'
        )
      end
    end
  end

  describe '#add_classes_to_estate_row' do
    subject(:classes) { helper.add_classes_to_estate_row(estate) }

    it { is_expected.to be_nil }

    context 'when estate delayed' do
      before do
        estate.status = :delayed
        estate.delayed_until = Date.current + 3.days
        estate.save
      end

      it { is_expected.to eq('table-secondary') }
    end
  end
end
