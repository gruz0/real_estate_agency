require 'rails_helper'

RSpec.describe 'people/edit', type: :view do
  let(:person) { create(:client) }

  it 'renders the edit person form' do
    assign(:type, 'Client')
    assign(:person, person)

    render

    assert_select 'h1', text: I18n.t('views.person.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', client_path(person), 'post' do
      assert_select 'input[name=?]', 'client[type]'

      assert_select 'input[name=?]', 'client[first_name]'

      assert_select 'input[name=?]', 'client[last_name]'

      assert_select 'input[name=?]', 'client[middle_name]'

      assert_select 'input[name=?]', 'client[phone_numbers]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: clients_path)
  end
end
