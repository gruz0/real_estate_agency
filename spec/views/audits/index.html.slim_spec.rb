require 'rails_helper'

RSpec.describe 'audits/index', type: :view do
  let(:audits) { Audited::Audit.last(2) }

  it 'renders a list of audits' do
    create(:city)
    create(:employee)

    assign(:audits, Kaminari.paginate_array(audits).page(1))

    render

    assert_select 'h1', text: I18n.t('views.audit.index.title'), count: 1

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: I18n.t('views.audit.index.id'), count: 1
        assert_select 'th', text: I18n.t('views.audit.index.user_id'), count: 1
        assert_select 'th', text: I18n.t('views.audit.index.auditable_type'), count: 1
        assert_select 'th', text: I18n.t('views.audit.index.auditable_id'), count: 1
        assert_select 'th', text: I18n.t('views.audit.index.action'), count: 1
        assert_select 'th', text: I18n.t('views.audit.index.created_at'), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2

        assert_select 'tr>td', text: 'City'.to_s, count: 1
        assert_select 'tr>td', text: 'Employee'.to_s, count: 1
        assert_select 'tr>td', text: 'create'.to_s, count: 2
      end
    end

    audits.each do |audit|
      expect(response.body).to have_link(I18n.t('views.show'), href: audit_path(audit))
    end
  end
end
