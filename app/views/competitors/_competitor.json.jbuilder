# frozen_string_literal: true

json.extract! competitor, :id, :name, :phone_numbers, :created_at, :updated_at
json.url competitor_url(competitor, format: :json)
