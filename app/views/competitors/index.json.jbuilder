# frozen_string_literal: true

json.array! @competitors, partial: 'competitors/competitor', as: :competitor
