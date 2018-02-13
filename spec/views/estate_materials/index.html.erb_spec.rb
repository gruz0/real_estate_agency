require 'rails_helper'

RSpec.describe 'estate_materials/index', type: :view do
  let(:estate_material1) { EstateMaterial.create!(name: 'Деревянный') }
  let(:estate_material2) { EstateMaterial.create!(name: 'Кирпичный') }
  let(:estate_materials) { [estate_material1, estate_material2] }

  it 'renders a list of estate_materials' do
    assign(:estate_materials, Kaminari.paginate_array(estate_materials).page(1))

    render

    assert_select 'h1', text: I18n.t('views.estate_material.index.title'), count: 1

    expect(response.body).to have_link(I18n.t('views.estate_material.index.new'), href: new_estate_material_path)

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: EstateMaterial.human_attribute_name(:id), count: 1
        assert_select 'th', text: EstateMaterial.human_attribute_name(:name), count: 1
        assert_select 'th', text: EstateMaterial.human_attribute_name(:created_at), count: 1
        assert_select 'th', text: EstateMaterial.human_attribute_name(:updated_at), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2
        assert_select 'tr>td', text: 'Деревянный'.to_s, count: 1
        assert_select 'tr>td', text: 'Кирпичный'.to_s, count: 1
        assert_select 'tr td', text: estate_material1.created_at.to_s, count: 4
      end
    end

    estate_materials.each do |estate_material|
      expect(response.body).to have_link(I18n.t('views.show'), href: estate_material_path(estate_material))
      expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_material_path(estate_material))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: estate_material_path(estate_material))
    end
  end
end
