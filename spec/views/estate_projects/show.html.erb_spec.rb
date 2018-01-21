require 'rails_helper'

RSpec.describe 'estate_projects/show', type: :view do
  before(:each) do
    @estate_project = assign(:estate_project, EstateProject.create!(name: 'Уральский'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Уральский/)
  end
end
