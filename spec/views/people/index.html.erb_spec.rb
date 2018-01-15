require 'rails_helper'

RSpec.describe 'people/index', type: :view do
  before(:each) do
    assign(:people, [
             Person.create!(
               first_name: 'First Name',
               last_name: 'Last Name',
               middle_name: 'Middle Name',
               primary_phone: 'Primary Phone',
               email: 'Email'
             ),
             Person.create!(
               first_name: 'First Name',
               last_name: 'Last Name',
               middle_name: 'Middle Name',
               primary_phone: 'Primary Phone',
               email: 'Email'
             )
           ])
  end

  it 'renders a list of people' do
    render
    assert_select 'tr>td', text: 'First Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Last Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Middle Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Primary Phone'.to_s, count: 2
    assert_select 'tr>td', text: 'Email'.to_s, count: 2
  end
end
