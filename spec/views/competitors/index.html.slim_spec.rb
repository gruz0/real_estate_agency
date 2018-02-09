require 'rails_helper'

RSpec.describe 'competitors/index', type: :view do
  let(:competitor1) do
    create(:competitor, name: 'Иванов Иван Иванович', phone_numbers: '+79001112233,111222')
  end
  let(:competitor2) do
    create(:competitor, name: 'Петров Сергей', phone_numbers: '+79993334455')
  end
  let(:competitors) { [competitor1, competitor2] }

  it 'renders a list of competitors' do
    assign(:competitors, competitors)

    render

    assert_select 'h1', text: I18n.t('views.competitor.index.title'), count: 1

    expect(response.body).to have_link(I18n.t('views.competitor.index.new'), href: new_competitor_path)

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: Competitor.human_attribute_name(:id), count: 1
        assert_select 'th', text: Competitor.human_attribute_name(:name), count: 1
        assert_select 'th', text: Competitor.human_attribute_name(:phone_numbers), count: 1
        assert_select 'th', text: Competitor.human_attribute_name(:created_at), count: 1
        assert_select 'th', text: Competitor.human_attribute_name(:updated_at), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2
        assert_select 'tr>td', text: 'Иванов Иван Иванович'.to_s, count: 1
        assert_select 'tr>td', text: '+79001112233,111222'.to_s, count: 1

        assert_select 'tr>td', text: 'Петров Сергей'.to_s, count: 1
        assert_select 'tr>td', text: '+79993334455'.to_s, count: 1

        assert_select 'tr td', text: competitor1.created_at.to_s, count: 4
      end
    end

    competitors.each do |competitor|
      expect(response.body).to have_link(I18n.t('views.show'), href: competitor_path(competitor))
      expect(response.body).to have_link(I18n.t('views.edit'), href: edit_competitor_path(competitor))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: competitor_path(competitor))
    end
  end
end
