require 'rails_helper'

RSpec.describe AuditsHelper, type: :helper do
  let(:audit) { Audited::Audit.last }

  describe '#render_audited_employee_for' do
    context 'when record creates by rake task and employee was not set' do
      it 'returns empty string' do
        create(:city)
        expect(helper.render_audited_employee_for(audit)).to eq('')
      end
    end

    context 'when record created by employee' do
      it 'returns link to employee' do
        employee = create(:employee, last_name: 'Иванов', first_name: 'Иван', middle_name: 'Иванович')

        Audited.audit_class.as_user(employee) do
          create(:city)
        end

        expect(helper.render_audited_employee_for(audit))
          .to eq(link_to('Иванов Иван Иванович', employee_path(audit.user)))
      end
    end

    context 'when employee destroyed' do
      it 'returns label Destroyed' do
        employee = create(:employee, last_name: 'Иванов', first_name: 'Иван', middle_name: 'Иванович')

        Audited.audit_class.as_user(employee) { create(:city) }

        audit = Audited::Audit.last

        employee.destroy

        expect(helper.render_audited_employee_for(audit)).to eq(I18n.t('helpers.label.destroyed'))
      end
    end
  end
end
