require 'rails_helper'

RSpec.describe 'estate_types/edit', type: :view do
  before(:each) do
    @estate_type = assign(:estate_type, EstateType.create!(name: 'Квартира'))
  end

  it 'renders the edit estate_type form' do
    render

    assert_select 'form[action=?][method=?]', estate_type_path(@estate_type), 'post' do
      assert_select 'input[name=?]', 'estate_type[name]'
    end
  end
end
