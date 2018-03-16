require 'rails_helper'

RSpec.describe 'logs/index', type: :view do
  let(:logs) do
    [
      create(:log,
             employee_id: 99,
             controller: 'TestController',
             action: 'destroy',
             entity_id: 10,
             error_messages: 'Error Messages',
             flash_notice: 'Flash Notice')
    ]
  end

  it 'renders a list of logs' do
    assign(:logs, Kaminari.paginate_array(logs).page(1))

    render

    assert_select 'h1', text: I18n.t('views.log.index.title'), count: 1

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: Log.human_attribute_name(:id), count: 1
        assert_select 'th', text: Log.human_attribute_name(:employee_id), count: 1
        assert_select 'th', text: Log.human_attribute_name(:action), count: 1
        assert_select 'th', text: Log.human_attribute_name(:error_messages), count: 1
        assert_select 'th', text: Log.human_attribute_name(:flash_notice), count: 1
        assert_select 'th', text: Log.human_attribute_name(:created_at), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 1

        assert_select 'tr>td', text: '99'.to_s, count: 1
        assert_select 'tr>td', text: 'TestController#destroy'.to_s, count: 1
        assert_select 'tr>td', text: 'Error Messages'.to_s, count: 1
        assert_select 'tr>td', text: 'Flash Notice'.to_s, count: 1
      end
    end

    logs.each do |log|
      expect(response.body).to have_link(I18n.t('views.show'), href: log_path(log))
    end
  end
end
