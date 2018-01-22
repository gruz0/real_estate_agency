require 'rails_helper'

RSpec.describe 'streets/edit', type: :view do
  before(:each) do
    assign(:action, :put)
    @street = assign(:street, Street.create!(city: create(:city), name: 'ул. Ленина'))
  end

  it 'renders the edit street form' do
    render

    assert_select 'form[action=?][method=?]', street_path(@street), 'post' do
      assert_select 'select[name=?]', 'street[city]'
      assert_select 'input[name=?][type=?]', 'street[city]', 'hidden'
      assert_select 'input[name=?]', 'street[name]'
    end
  end
end
