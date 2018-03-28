require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#page_title' do
    context 'when title is set' do
      it 'returns title' do
        expect(helper.page_title('Title')).to eq('Title')
      end
    end

    context 'when title is not set' do
      it 'returns default title' do
        expect(helper.page_title('')).to eq(I18n.t('views.layout.title'))
      end
    end
  end
end
