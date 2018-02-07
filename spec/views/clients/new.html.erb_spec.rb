require 'rails_helper'

RSpec.describe 'clients/new', type: :view do
  let(:client) { build(:client) }

  it 'renders new client form' do
    assign(:client, client)

    render

    assert_select 'h1', text: I18n.t('views.client.new.title'), count: 1

    assert_select 'form[action=?][method=?]', clients_path, 'post' do
      assert_select 'input[name=?]', 'client[full_name]'

      assert_select 'input[name=?]', 'client[phone_numbers]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: clients_path)
  end
end
