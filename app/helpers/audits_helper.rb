# frozen_string_literal: true

module AuditsHelper
  def render_audited_employee_for(audit)
    return '' unless audit.user

    link_to(person_fullname(audit.user), employee_path(audit.user))
  end

  def audit_row_class_depends_on(action)
    action == 'destroy' ? 'table-danger' : ''
  end
end
