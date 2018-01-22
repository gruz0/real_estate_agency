require 'rails_helper'

RSpec.describe 'streets/new', type: :view do
  before(:each) do
    assign(:action, :post)
    assign(:street, Street.new(city: create(:city), name: 'ул. Ленина'))
  end

  it 'renders new street form' do
    render

    assert_select 'form[action=?][method=?]', streets_path, 'post' do
      assert_select 'select[name=?]', 'street[city]'
      assert_select 'input[name=?][type=?]', 'street[city]', 'hidden', false
      assert_select 'input[name=?]', 'street[name]'
    end
  end
end
