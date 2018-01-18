require 'rails_helper'

RSpec.describe 'people/index', type: :view do
  before(:each) do
    assign(:type, 'Client')
    assign(:people, [
             Client.create!(
               first_name: 'First Name',
               last_name: 'Last Name',
               middle_name: 'Middle Name',
               phone_numbers: 'Primary Phone'
             ),
             Client.create!(
               first_name: 'First Name',
               last_name: 'Last Name',
               middle_name: 'Middle Name',
               phone_numbers: 'Primary Phone'
             )
           ])
  end

  it 'renders a list of people' do
    render
    assert_select 'tr>td', text: 'Client'.to_s, count: 2
    assert_select 'tr>td', text: 'First Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Last Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Middle Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Primary Phone'.to_s, count: 2
  end
end
