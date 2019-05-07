RSpec.shared_examples 'addresses controller forbidden index action for non service admin' do
  it 'redirects to root_path with alert' do
    get :index, params: {}
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
  end
end

RSpec.shared_examples 'addresses controller forbidden show action for non service admin' do
  it 'redirects to root_path with alert' do
    get :show, params: { id: address.to_param }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
  end
end

RSpec.shared_examples 'addresses controller forbidden destroy action for non service admin' do
  it 'redirects to root_path with alert' do
    delete :destroy, params: { id: address.to_param }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
  end
end
