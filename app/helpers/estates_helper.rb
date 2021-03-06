# frozen_string_literal: true

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

  def clickable_phones_for(phone_numbers)
    return '' if phone_numbers.blank?

    content = phone_numbers.split(',').map(&:strip).map do |phone_number|
      tag.a(phone_number, href: "tel://#{phone_number}")
    end

    safe_join content, ', '
  end

  def streets_depends_on_city_for(estate)
    if estate.address&.street
      Street.reorder('name ASC').where(city: estate.address.street.city)
    else
      City.ordered_by_name.first.street.ordered_by_name
    end
  end

  def format_price(price)
    number_to_currency("#{price}000", precision: 0, delimiter: ' ', format: '%n')
  end

  def address_full_name_for(estate)
    estate.address.full_name + apartment_number_for(estate)
  end

  def datepicker_input(form, field)
    tag.td  do
      concat(form.label(:delayed_until))
      concat(form.text_field(field, id: 'datepicker', class: 'form-control'))
    end
  end

  def delayed_until(estate)
    return unless estate.delayed?

    tag.div class: 'row col-lg-10' do
      tag.div class: 'alert alert-secondary' do
        t('views.estate.show.delayed_until', delayed_until: estate.delayed_until)
      end
    end
  end

  def cancel_delay(estate)
    return unless estate.delayed?

    form_with(model: estate, local: true, url: cancel_delay_estate_path(estate), method: :delete) do |form|
      concat(tag(:hr))
      concat(form.submit(class: 'btn btn-warning', value: t('helpers.submit.cancel_delay')))
    end
  end

  def add_classes_to_estate_row(estate)
    return if estate.active?

    'table-secondary'
  end

  private

  def apartment_number_for(estate)
    estate.apartment_number? ? ", #{estate.apartment_number}" : ''
  end
end
