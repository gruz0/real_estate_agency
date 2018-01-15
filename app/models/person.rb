class Person < ApplicationRecord
  has_many :employees, dependent: :destroy
end
