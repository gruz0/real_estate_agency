json.extract! employee, :id, :email, :first_name, :last_name, :middle_name, :phone_numbers, :created_at, :updated_at
json.url employee_url(employee, format: :json)
