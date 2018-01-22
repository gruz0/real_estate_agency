require 'rails_helper'

RSpec.describe 'streets/new', type: :view do
  let(:city) { create(:city) }
  let(:street) { build(:street, city: city) }

  before(:each) do
    assign(:action, :post)
    assign(:city, city)
    assign(:street, street)
  end

  it 'renders new street form' do
    render

    assert_select 'form[action=?][method=?]', city_streets_path(city), 'post' do
      assert_select 'input[name=?]', 'street[name]'
    end
  end
end
