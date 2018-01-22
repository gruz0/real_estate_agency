require 'rails_helper'

RSpec.describe 'streets/edit', type: :view do
  let(:city) { create(:city) }
  let(:street) { create(:street, city: city) }

  before(:each) do
    assign(:action, :put)
    assign(:city, city)
    assign(:street, street)
  end

  it 'renders the edit street form' do
    render

    assert_select 'form[action=?][method=?]', city_street_path(city, street), 'post' do
      assert_select 'input[name=?]', 'street[name]'
    end
  end
end
