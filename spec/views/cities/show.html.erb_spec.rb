require 'rails_helper'

RSpec.describe 'cities/show', type: :view do
  before(:each) do
    @city = assign(:city, City.create!(name: 'Нефтеюганск'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Нефтеюганск/)
  end
end
