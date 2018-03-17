require 'rails_helper'

RSpec.describe 'logs/show', type: :view do
  let(:log) do
    create(:log,
           employee_id: 99,
           controller: 'TestController',
           action: 'destroy',
           entity_id: 10,
           params: 'Form Params',
           error_messages: 'Error Messages',
           flash_notice: 'Flash Notice')
  end

  it 'renders attributes in <p>' do
    assign(:log, log)

    render

    expect(rendered).to match(I18n.t('views.log.show.title', id: log.id))

    expect(rendered).to match(/99/)
    expect(rendered).to match(/TestController/)
    expect(rendered).to match(/destroy/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/Form Params/)
    expect(rendered).to match(/Error Messages/)
    expect(rendered).to match(/Flash Notice/)
    expect(rendered).to match(/#{I18n.l(log.created_at, format: :custom)}/)

    expect(response.body).to have_link(I18n.t('views.back'), href: logs_path)
  end
end
