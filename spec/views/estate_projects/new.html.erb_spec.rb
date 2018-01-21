require 'rails_helper'

RSpec.describe 'estate_projects/new', type: :view do
  before(:each) do
    assign(:estate_project, EstateProject.new(name: 'Уральский'))
  end

  it 'renders new estate_project form' do
    render

    assert_select 'form[action=?][method=?]', estate_projects_path, 'post' do
      assert_select 'input[name=?]', 'estate_project[name]'
    end
  end
end
