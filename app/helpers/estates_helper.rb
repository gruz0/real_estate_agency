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
end
