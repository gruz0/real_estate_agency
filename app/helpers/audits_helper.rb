module AuditsHelper
  def render_audited_employee_for(audit)
    return '' if audit.user_id.blank?

    link_to(person_fullname(audit.user), employee_path(audit.user))
  end
end
