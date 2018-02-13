require 'rails_helper'

RSpec.describe 'clients/index', type: :view do
  let(:client1) do
    create(:client, full_name: 'Иванов Иван Иванович', phone_numbers: '+79001112233')
  end
  let(:client2) do
    create(:client, full_name: 'Петров Сергей', phone_numbers: '+79993334455')
  end
  let(:clients) { [client1, client2] }

  it 'renders a list of clients' do
    assign(:clients, Kaminari.paginate_array(clients).page(1))

    render

    assert_select 'h1', text: I18n.t('views.client.index.title'), count: 1

    expect(response.body).to have_link(I18n.t('views.client.index.new'), href: new_client_path)

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: Client.human_attribute_name(:id), count: 1
        assert_select 'th', text: Client.human_attribute_name(:full_name), count: 1
        assert_select 'th', text: Client.human_attribute_name(:phone_numbers), count: 1
        assert_select 'th', text: Client.human_attribute_name(:created_at), count: 1
        assert_select 'th', text: Client.human_attribute_name(:updated_at), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2
        assert_select 'tr>td', text: 'Иванов Иван Иванович'.to_s, count: 1
        assert_select 'tr>td', text: '+79001112233'.to_s, count: 1

        assert_select 'tr>td', text: 'Петров Сергей'.to_s, count: 1
        assert_select 'tr>td', text: '+79993334455'.to_s, count: 1
      end
    end

    clients.each do |client|
      expect(response.body).to have_link(I18n.t('views.show'), href: client_path(client))
      expect(response.body).to have_link(I18n.t('views.edit'), href: edit_client_path(client))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: client_path(client))
    end
  end
end
