json.extract! estate, :id, :client, :created_by_employee, :responsible_employee,
              :estate_type, :estate_project, :estate_material, :address, :apartment_number, :number_of_rooms,
              :floor, :number_of_floors, :total_square_meters, :kitchen_square_meters,
              :description, :price, :status, :created_at, :updated_at
json.url estate_url(estate, format: :json)
