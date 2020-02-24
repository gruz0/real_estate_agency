# frozen_string_literal: true

json.array! @estates, partial: 'estates/estate', as: :estate
