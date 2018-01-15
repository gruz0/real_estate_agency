require 'rails_helper'

RSpec.describe 'people/show', type: :view do
  before(:each) do
    @person = assign(:person, Person.create!(
                                first_name: 'First Name',
                                last_name: 'Last Name',
                                middle_name: 'Middle Name',
                                primary_phone: 'Primary Phone',
                                email: 'Email'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Middle Name/)
    expect(rendered).to match(/Primary Phone/)
    expect(rendered).to match(/Email/)
  end
end
