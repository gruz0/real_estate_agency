require 'rails_helper'

RSpec.describe 'estate_types/show', type: :view do
  before(:each) do
    @estate_type = assign(:estate_type, EstateType.create!(name: 'Квартира'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Квартира/)
  end
end
