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
  end

  describe '#audit_row_class_depends_on' do
    it 'returns empty string on create action' do
      create(:city)

      expect(helper.audit_row_class_depends_on(audit.action)).to eq('')
    end

    it 'returns empty string on update action' do
      city = create(:city)
      city.update!(name: 'Test')

      expect(helper.audit_row_class_depends_on(audit.action)).to eq('')
    end

    it 'returns table-danger on destroy action' do
      city = create(:city)
      city.destroy

      expect(helper.audit_row_class_depends_on(audit.action)).to eq('table-danger')
    end
  end
end
