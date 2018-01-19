FactoryBot.define do
  factory :person do
    type 'Client'
    last_name 'Иванов'
    first_name 'Сергей'
    phone_numbers '+79001112233,+79998001111'

    factory :client do
      type 'Client'
    end

    factory :employee do
      type 'Employee'
    end
  end
end
