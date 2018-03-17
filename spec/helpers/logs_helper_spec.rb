require 'rails_helper'

RSpec.describe LogsHelper, type: :helper do
  let(:log) { build(:log, error_messages: error_messages, flash_notice: flash_notice) }

  describe '#row_class_depends_on_log_message' do
    context 'when error_messages is not set and flash_notice is set' do
      let(:error_messages) { nil }
      let(:flash_notice) { 'City was successfully created' }

      it 'concats values' do
        expect(helper.row_class_depends_on_log_message(log)).to be_empty
      end
    end

    context 'when error_messages is set and flash_notice is not set' do
      let(:error_messages) { 'Error message' }
      let(:flash_notice) { nil }

      it 'returns empty string' do
        expect(helper.row_class_depends_on_log_message(log)).to eq('table-danger')
      end
    end
  end
end
