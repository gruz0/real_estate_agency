$(document).on 'turbolinks:load', () ->
  $('#filterize_competitors').on 'click', ->
    filter = {
      phone_numbers: $('#filter_phone_numbers').val()
    }
    window.location = '/competitors?' + encodeQueryData(filter)
    return

  $('#reset_competitors_filter').on 'click', ->
    window.location = '/competitors'
    return

  return
