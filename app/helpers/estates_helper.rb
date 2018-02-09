module EstatesHelper
  def number_of_floors_for(estate)
    if estate.floor.present?
      if estate.number_of_floors.present?
        "#{estate.floor}/#{estate.number_of_floors}"
      else
        "#{estate.floor}/#{t('views.is_not_set.other')}"
      end
    elsif estate.number_of_floors.present?
      "#{t('views.is_not_set.one')}/#{estate.number_of_floors}"
    else
      "#{t('views.is_not_set.one')}/#{t('views.is_not_set.other')}"
    end
  end

  def number_of_rooms_for(estate)
    return estate.number_of_rooms.to_s if estate.number_of_rooms.present?

    t('views.is_not_set.other')
  end

  def clicable_phones_for(client)
    phone_numbers = client.phone_numbers
    return '' if phone_numbers.blank?

    content = phone_numbers.split(',').map do |phone_number|
      if phone_number =~ /\A[+\d]+\z/
        content_tag(:a, phone_number.strip, href: "tel://#{phone_number.strip}")
      else
        content_tag(:span, phone_number.strip)
      end
    end

    safe_join content, ', '
  end
end
