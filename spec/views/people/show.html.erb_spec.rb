require 'rails_helper'

RSpec.describe 'people/show', type: :view do
  before(:each) do
    @client = assign(:person, Client.create!(
                                last_name: 'Иванов',
                                first_name: 'Иван',
                                middle_name: 'Иванович',
                                phone_numbers: '+79991112233'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Иванов/)
    expect(rendered).to match(/Иван/)
    expect(rendered).to match(/Иванович/)
    expect(rendered).to match(/\+79991112233/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: sti_person_path(@client.type, @client, :edit))
    expect(response.body).to have_link(I18n.t('views.back'), href: sti_person_path(@client.type))
  end
end
