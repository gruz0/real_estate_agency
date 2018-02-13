module PeopleHelper
  def person_fullname(person)
    return '' unless person

    "#{person.last_name} #{person.first_name} #{person.middle_name}".strip
  end

  def person_shortname(person)
    return '' unless person

    middle_name = person.middle_name.present? ? "#{person.middle_name[0]}." : ''
    "#{person.last_name} #{person.first_name[0]}.#{middle_name}".strip
  end
end
