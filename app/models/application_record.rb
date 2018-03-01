class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :ordered_by_name, -> { reorder('name ASC') }
end
