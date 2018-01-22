require 'rails_helper'

RSpec.describe 'streets/show', type: :view do
  before(:each) do
    @street = assign(:street, Street.create!(city: create(:city, name: 'Нефтеюганск'), name: 'ул. Ленина'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Нефтеюганск/)
    expect(rendered).to match(/ул. Ленина/)
  end
end
