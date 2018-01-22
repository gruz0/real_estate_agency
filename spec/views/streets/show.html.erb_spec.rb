require 'rails_helper'

RSpec.describe 'streets/show', type: :view do
  let(:city) { create(:city, name: 'Нефтеюганск') }

  before(:each) do
    @city = assign(:city, city)
    @street = assign(:street, Street.create!(city: city, name: 'ул. Ленина'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Нефтеюганск/)
    expect(rendered).to match(/ул. Ленина/)
  end
end
