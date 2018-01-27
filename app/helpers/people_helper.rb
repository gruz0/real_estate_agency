module PeopleHelper
  # FIXME: It should be covered with specs
  def sti_person_path(type = 'person', person = nil, action = nil)
    send "#{format_sti(action, type, person)}_path", person
  end

  # FIXME: It should be covered with specs
  def format_sti(action, type, person)
    action || person ? "#{format_action(action)}#{type.underscore}" : type.underscore.pluralize.to_s
  end

  # FIXME: It should be covered with specs
  def format_action(action)
    action ? "#{action}_" : ''
  end

  def person_fullname(person)
    "#{person.last_name} #{person.first_name} #{person.middle_name}".strip
  end

  def person_shortname(person)
    middle_name = person.middle_name.present? ? "#{person.middle_name[0]}." : ''
    "#{person.last_name} #{person.first_name[0]}.#{middle_name}".strip
  end
end
