# frozen_string_literal: true

json.array! @addresses, partial: 'addresses/address', as: :address
