module PeopleHelper
  def sti_person_path(type = 'person', person = nil, action = nil)
    send "#{format_sti(action, type, person)}_path", person
  end

  def format_sti(action, type, person)
    action || person ? "#{format_action(action)}#{type.underscore}" : type.underscore.pluralize.to_s
  end

  def format_action(action)
    action ? "#{action}_" : ''
  end
end
