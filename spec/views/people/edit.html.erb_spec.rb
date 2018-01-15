require 'rails_helper'

RSpec.describe 'people/edit', type: :view do
  before(:each) do
    @person = assign(:person, Person.create!(
                                first_name: 'MyString',
                                last_name: 'MyString',
                                middle_name: 'MyString',
                                primary_phone: 'MyString',
                                email: 'MyString'
    ))
  end

  it 'renders the edit person form' do
    render

    assert_select 'form[action=?][method=?]', person_path(@person), 'post' do
      assert_select 'input[name=?]', 'person[first_name]'

      assert_select 'input[name=?]', 'person[last_name]'

      assert_select 'input[name=?]', 'person[middle_name]'

      assert_select 'input[name=?]', 'person[primary_phone]'

      assert_select 'input[name=?]', 'person[email]'
    end
  end
end
