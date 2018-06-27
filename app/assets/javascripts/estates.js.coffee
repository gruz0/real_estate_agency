loadStreets = (cityId, streetSelector) ->
  $.ajax "/cities/#{cityId}/streets/search",
    dataType: 'json'
    success: (data, textStatus, jqXHR) ->
      populateStreets(streetSelector, data)

populateStreets = (streetSelector, json) ->
  streets = []
  $.each json, (_, street) ->
    streets.push "<option value='#{street.id}'>#{street.name}</li>"
    return

  $(streetSelector).html(streets.join(''))

$(document).on 'turbolinks:load', () ->
  $('#filter').on 'click', ->
    filterCity = ''
    filterStreet = ''

    if $('#filter_city').val() && $('#filter_street').val()
      filterCity = $('#filter_city').val()
      filterStreet = $('#filter_street').val()

    filter = {
      id: $('#filter_id').val(),
      estate_city: filterCity,
      estate_street: filterStreet,
      estate_project: $('#filter_estate_project').val(),
      number_of_rooms: $('#filter_number_of_rooms').val(),
      floor_from: $('#filter_floor_from').val(),
      floor_to: $('#filter_floor_to').val(),
      price_from: $('#filter_price_from').val(),
      price_to: $('#filter_price_to').val(),
      client_phone_numbers: $('#filter_client_phone_numbers').val(),
      responsible_employee: $('#filter_responsible_employee').val()
    }
    window.location = '/estates?' + encodeQueryData(filter)
    return

  $('#reset_filter').on 'click', ->
    window.location = '/estates'
    return

  $('#estate_city').on 'change', ->
    loadStreets($(this).val(), '#city_streets')

  $('#filter_city').on 'change', ->
    loadStreets($(this).val(), '#filter_street')

  return
