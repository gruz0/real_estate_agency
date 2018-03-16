FactoryBot.define do
  factory :log do
    employee_id 1
    controller 'CitiesController'
    action 'Create'
    entity_id 2
    params 'Params'
    error_messages 'Unable to save City'
    flash_notice 'City was successfully created'
  end
end
