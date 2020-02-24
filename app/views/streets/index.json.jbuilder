# frozen_string_literal: true

json.array! @streets, partial: 'streets/street', as: :street
