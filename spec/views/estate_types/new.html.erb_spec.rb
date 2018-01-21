require 'rails_helper'

RSpec.describe 'estate_types/new', type: :view do
  before(:each) do
    assign(:estate_type, EstateType.new(name: 'Квартира'))
  end

  it 'renders new estate_type form' do
    render

    assert_select 'form[action=?][method=?]', estate_types_path, 'post' do
      assert_select 'input[name=?]', 'estate_type[name]'
    end
  end
end
