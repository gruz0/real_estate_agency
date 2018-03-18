require 'rails_helper'

RSpec.describe 'audits/show', type: :view do
  let(:audit) { Audited::Audit.last }

  it 'renders attributes in <p>' do
    create(:city, name: 'Нефтеюганск')

    assign(:audit, audit)

    render

    expect(rendered).to match(I18n.t('views.audit.show.title', id: audit.id))

    expect(rendered).to match(/City/)
    expect(rendered).to match(/create/)
    expect(rendered).to match(/Нефтеюганск/)
    expect(rendered).to match(/#{I18n.l(audit.created_at, format: :short)}/)

    expect(response.body).to have_link(I18n.t('views.back'), href: audits_path)
  end
end
