# frozen_string_literal: true

json.extract! client, :id, :full_name, :phone_numbers, :created_at, :updated_at
json.url client_url(client, format: :json)
