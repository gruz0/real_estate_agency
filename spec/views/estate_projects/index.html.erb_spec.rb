require 'rails_helper'

RSpec.describe 'estate_projects/index', type: :view do
  before(:each) do
    assign(:estate_projects, [
             EstateProject.create!(name: 'Уральский'),
             EstateProject.create!(name: 'Ленинградский')
           ])
  end

  it 'renders a list of estate_projects' do
    render
    assert_select 'tr>td', text: 'Уральский'.to_s, count: 1
    assert_select 'tr>td', text: 'Ленинградский'.to_s, count: 1
  end
end
