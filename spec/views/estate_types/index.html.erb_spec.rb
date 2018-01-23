require 'rails_helper'

RSpec.describe 'estate_types/index', type: :view do
  let(:estate_type1) { EstateType.create!(name: 'Квартира') }
  let(:estate_type2) { EstateType.create!(name: 'Дом') }

  before(:each) do
    @estate_types = assign(:estate_types, [estate_type1, estate_type2])
  end

  it 'renders a list of estate_types' do
    render

    assert_select 'h1', text: I18n.t('views.estate_type.index.title'), count: 1

    expect(response.body).to have_link(I18n.t('views.estate_type.index.new'), href: new_estate_type_path)

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: EstateType.human_attribute_name(:id), count: 1
        assert_select 'th', text: EstateType.human_attribute_name(:name), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2
        assert_select 'tr>td', text: 'Квартира'.to_s, count: 1
        assert_select 'tr>td', text: 'Дом'.to_s, count: 1
      end
    end

    @estate_types.each do |estate_type|
      expect(response.body).to have_link(I18n.t('views.show'), href: estate_type_path(estate_type))
      expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_type_path(estate_type))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: estate_type_path(estate_type))
    end
  end
end
