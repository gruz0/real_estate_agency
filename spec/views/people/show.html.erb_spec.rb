require 'rails_helper'

RSpec.describe 'people/show', type: :view do
  let(:client) do
    create(:client, last_name: 'Иванов', first_name: 'Олег', middle_name: 'Сергеевич', phone_numbers: '+79991112233')
  end

  it 'renders attributes in <p>' do
    assign(:person, client)

    render

    expect(rendered).to match(/Иванов/)
    expect(rendered).to match(/Олег/)
    expect(rendered).to match(/Сергеевич/)
    expect(rendered).to match(/\+79991112233/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: sti_person_path(client.type, client, :edit))
    expect(response.body).to have_link(I18n.t('views.back'), href: sti_person_path(client.type))
  end
end
