RSpec.shared_examples :addresses_controller_forbidden_index_action_for_non_service_admin do
  it 'redirects to root_path with alert' do
    get :index, params: {}
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
  end
end

RSpec.shared_examples :addresses_controller_forbidden_show_action_for_non_service_admin do
  it 'redirects to root_path with alert' do
    get :show, params: { id: address.to_param }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
  end
end

RSpec.shared_examples :addresses_controller_forbidden_destroy_action_for_non_service_admin do
  it 'redirects to root_path with alert' do
    delete :destroy, params: { id: address.to_param }
    expect(response).to be_redirect
    expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
  end
end
