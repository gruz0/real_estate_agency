require 'rails_helper'

RSpec.describe 'clients/edit', type: :view do
  let(:client) { create(:client) }

  it 'renders the edit client form' do
    assign(:client, client)

    render

    assert_select 'h1', text: I18n.t('views.client.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', client_path(client), 'post' do
      assert_select 'input[name=?]', 'client[first_name]'

      assert_select 'input[name=?]', 'client[last_name]'

      assert_select 'input[name=?]', 'client[middle_name]'

      assert_select 'input[name=?]', 'client[phone_numbers]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: clients_path)
  end
end
