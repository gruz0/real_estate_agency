class Client < Person
  has_many :estate, dependent: :destroy
end