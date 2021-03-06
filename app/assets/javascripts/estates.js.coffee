loadStreets = (cityId, streetSelector, addFirstEmptyItem = false) ->
  unless cityId
    $(streetSelector).html("<option value=''>#{i18n_all}</li>")
    return

  $.ajax "/cities/#{cityId}/streets/search",
    dataType: 'json'
    success: (data, textStatus, jqXHR) ->
      populateStreets(streetSelector, data, addFirstEmptyItem)

populateStreets = (streetSelector, json, addFirstEmptyItem) ->
  streets = []

  if addFirstEmptyItem
    streets.push "<option value=''>#{i18n_all}</li>"

  $.each json, (_, street) ->
    streets.push "<option value='#{street.id}'>#{street.name}</li>"
    return

  $(streetSelector).html(streets.join(''))

$(document).on 'turbolinks:load', () ->
  $('#datepicker').datepicker({
    language: 'ru',
    autoclose: true,
    clearBtn: true,
    format: 'yyyy-mm-dd',
    orientation: 'bottom left'
  })

  $('#filterize_estates').on 'click', ->
    filterCity = ''
    filterStreet = ''
    filterBuildingNumber = ''

    if $('#filter_city').val()
      filterCity = $('#filter_city').val()

      if $('#filter_street').val()
        filterStreet = $('#filter_street').val()

        if $('#filter_building_number').val()
          filterBuildingNumber = $('#filter_building_number').val()

    filter = {
      id: $('#filter_id').val(),
      estate_city: filterCity,
      estate_street: filterStreet,
      estate_building_number: filterBuildingNumber,
      estate_project: $('#filter_estate_project').val(),
      number_of_rooms: $('#filter_number_of_rooms').val(),
      floor_from: $('#filter_floor_from').val(),
      floor_to: $('#filter_floor_to').val(),
      price_from: $('#filter_price_from').val(),
      price_to: $('#filter_price_to').val(),
      total_square_meters_from: $('#filter_total_square_meters_from').val(),
      total_square_meters_to: $('#filter_total_square_meters_to').val(),
      client_phone_numbers: $('#filter_client_phone_numbers').val(),
      responsible_employee: $('#filter_responsible_employee').val(),
      status: $('#filter_status').val()
    }
    window.location = '/estates?' + encodeQueryData(filter)
    return

  $('#reset_estates_filter').on 'click', ->
    window.location = '/estates'
    return

  $('#estate_city').on 'change', ->
    loadStreets($(this).val(), '#city_streets')

  $('#filter_city').on 'change', ->
    loadStreets($(this).val(), '#filter_street', true)

  return
