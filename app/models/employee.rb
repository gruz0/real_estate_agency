class Employee < Person
  has_many :estate, dependent: :destroy
end
