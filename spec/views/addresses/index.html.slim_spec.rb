require 'rails_helper'

RSpec.describe 'addresses/index', type: :view do
  let(:city) { create(:city, name: 'Нефтеюганск') }
  let(:street) { create(:street, city: city, name: 'ул. Ленина') }
  let(:addresses) do
    [
      Address.create!(street: street, building_number: '4/13'),
      Address.create!(street: street, building_number: '5а')
    ]
  end

  it 'renders a list of addresses' do
    assign(:addresses, Kaminari.paginate_array(addresses).page(1))

    render

    assert_select 'h1', text: I18n.t('views.address.index.title'), count: 1

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: Address.human_attribute_name(:id), count: 1
        assert_select 'th', text: City.model_name.human, count: 1
        assert_select 'th', text: Street.model_name.human, count: 1
        assert_select 'th', text: Address.human_attribute_name(:building_number), count: 1
        assert_select 'th', text: Address.human_attribute_name(:created_at), count: 1
        assert_select 'th', text: Address.human_attribute_name(:updated_at), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2
        assert_select 'tr>td', text: 'Нефтеюганск'.to_s, count: 2
        assert_select 'tr>td', text: 'ул. Ленина'.to_s, count: 2
        assert_select 'tr>td', text: '4/13'.to_s, count: 1
        assert_select 'tr>td', text: '5а'.to_s, count: 1
      end
    end

    addresses.each do |address|
      expect(response.body).to have_link(I18n.t('views.show'), href: address_path(address))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: address_path(address))
    end
  end
end
