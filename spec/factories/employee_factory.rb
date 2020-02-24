# frozen_string_literal: true

FactoryBot.define do
  factory :employee, aliases: %i[responsible_employee created_by_employee] do
    email { FFaker::Internet.safe_email }
    password { FFaker::Internet.password }
    last_name { FFaker::NameRU.last_name }
    first_name { FFaker::NameRU.first_name }

    trait :locked do
      locked_at { Time.current }
    end
  end
end
