# frozen_string_literal: true

json.extract! audit, :id, :created_at, :updated_at
json.url audit_url(audit, format: :json)
