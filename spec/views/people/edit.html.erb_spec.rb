require 'rails_helper'

RSpec.describe 'people/edit', type: :view do
  before(:each) do
    @type = assign(:type, 'Client')
    @person = assign(:person, Client.create!(
                                first_name: 'MyString',
                                last_name: 'MyString',
                                middle_name: 'MyString',
                                phone_numbers: '+79001112233'
    ))
  end

  it 'renders the edit person form' do
    render

    assert_select 'form[action=?][method=?]', client_path(@person), 'post' do
      assert_select 'input[name=?]', 'client[type]'

      assert_select 'input[name=?]', 'client[first_name]'

      assert_select 'input[name=?]', 'client[last_name]'

      assert_select 'input[name=?]', 'client[middle_name]'

      assert_select 'input[name=?]', 'client[phone_numbers]'
    end
  end
end
