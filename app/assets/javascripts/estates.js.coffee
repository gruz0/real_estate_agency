$(document).on 'turbolinks:load', () ->
  $('#filter').on 'click', ->
    filter = {
      id: $('#filter_id').val(),
      estate_project: $('#filter_estate_project').val(),
      number_of_rooms: $('#filter_number_of_rooms').val(),
      floor: $('#filter_floor').val(),
      price_to: $('#filter_price_to').val(),
      responsible_employee: $('#filter_responsible_employee').val()
    }
    window.location = '/estates?' + encodeQueryData(filter)
    return

  $('#reset_filter').on 'click', ->
    window.location = '/estates'
    return

  $('#estate_city').on 'change', ->
    $.ajax "/cities/#{$(this).val()}/streets/search",
      dataType: 'json'
      success: (data, textStatus, jqXHR) ->
        streets = []
        $.each data, (_, street) ->
          streets.push "<option value='#{street.id}'>#{street.name}</li>"
          return

        $('#city_streets').html(streets.join(''))
        return
    return
  return
