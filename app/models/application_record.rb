class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  default_scope -> { order('id DESC') }
  scope :ordered_by_name, -> { reorder('name ASC') }
end
