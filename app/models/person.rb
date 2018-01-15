class Person < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_many :clients, dependent: :destroy
end
