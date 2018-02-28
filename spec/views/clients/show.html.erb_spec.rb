require 'rails_helper'

RSpec.describe 'clients/show', type: :view do
  let(:client) do
    create(:client, full_name: 'Иванов Олег Сергеевич', phone_numbers: '+79991112233')
  end

  it 'renders attributes in <p>' do
    assign(:client, client)

    render

    expect(rendered).to match(I18n.t('views.client.show.title', id: client.id))

    expect(rendered).to match(/Иванов Олег Сергеевич/)
    expect(rendered).to match(/\+79991112233/)
    expect(rendered).to match(/#{I18n.l(client.created_at, format: :short)}/)
    expect(rendered).to match(/#{I18n.l(client.updated_at, format: :short)}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_client_path(client))
    expect(response.body).to have_link(I18n.t('views.back'), href: clients_path)
  end
end
