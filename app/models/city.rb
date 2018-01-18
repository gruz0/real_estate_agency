class City < ApplicationRecord
  has_many :street, dependent: :destroy
end
