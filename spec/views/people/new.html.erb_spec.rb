require 'rails_helper'

RSpec.describe 'people/new', type: :view do
  before(:each) do
    assign(:type, 'Client')
    assign(:person, Client.new(
                      first_name: 'MyString',
                      last_name: 'MyString',
                      middle_name: 'MyString',
                      phone_numbers: 'MyString'
    ))
  end

  it 'renders new person form' do
    render

    assert_select 'form[action=?][method=?]', clients_path, 'post' do
      assert_select 'input[name=?]', 'client[type]'

      assert_select 'input[name=?]', 'client[first_name]'

      assert_select 'input[name=?]', 'client[last_name]'

      assert_select 'input[name=?]', 'client[middle_name]'

      assert_select 'input[name=?]', 'client[phone_numbers]'
    end
  end
end
