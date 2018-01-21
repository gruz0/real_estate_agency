require 'rails_helper'

RSpec.describe 'estate_projects/edit', type: :view do
  before(:each) do
    @estate_project = assign(:estate_project, EstateProject.create!(name: 'Уральский'))
  end

  it 'renders the edit estate_project form' do
    render

    assert_select 'form[action=?][method=?]', estate_project_path(@estate_project), 'post' do
      assert_select 'input[name=?]', 'estate_project[name]'
    end
  end
end
