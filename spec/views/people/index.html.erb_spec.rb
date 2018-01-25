require 'rails_helper'

RSpec.describe 'people/index', type: :view do
  let(:client1) do
    Client.create!(
      last_name: 'Иванов',
      first_name: 'Иван',
      middle_name: 'Иванович',
      phone_numbers: '+79001112233'
    )
  end
  let(:client2) do
    Client.create!(
      last_name: 'Петров',
      first_name: 'Сергей',
      phone_numbers: '+79993334455'
    )
  end

  before(:each) do
    assign(:type, 'Client')
    @clients = assign(:people, [client1, client2])
  end

  it 'renders a list of people' do
    render

    assert_select 'h1', text: I18n.t('views.person.index.title'), count: 1

    expect(response.body).to have_link(I18n.t('views.person.index.new'), href: new_client_path)

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: Person.human_attribute_name(:id), count: 1
        assert_select 'th', text: Person.human_attribute_name(:fullname), count: 1
        assert_select 'th', text: Person.human_attribute_name(:phone_numbers), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2
        assert_select 'tr>td', text: 'Иванов Иван Иванович'.to_s, count: 1
        assert_select 'tr>td', text: '+79001112233'.to_s, count: 1

        assert_select 'tr>td', text: 'Петров Сергей'.to_s, count: 1
        assert_select 'tr>td', text: '+79993334455'.to_s, count: 1
      end
    end

    @clients.each do |client|
      expect(response.body).to have_link(I18n.t('views.show'), href: sti_person_path(client.type, client))
      expect(response.body).to have_link(I18n.t('views.edit'), href: sti_person_path(client.type, client, :edit))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: sti_person_path(client.type, client))
    end
  end
end
