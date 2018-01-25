require 'rails_helper'

RSpec.describe 'people/new', type: :view do
  let(:client) { build(:client) }

  it 'renders new person form' do
    assign(:type, 'Client')
    assign(:person, client)

    render

    assert_select 'h1', text: I18n.t('views.person.new.title'), count: 1

    assert_select 'form[action=?][method=?]', clients_path, 'post' do
      assert_select 'input[name=?]', 'client[type]'

      assert_select 'input[name=?]', 'client[first_name]'

      assert_select 'input[name=?]', 'client[last_name]'

      assert_select 'input[name=?]', 'client[middle_name]'

      assert_select 'input[name=?]', 'client[phone_numbers]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: sti_person_path(client.type))
  end
end
