class Log < ApplicationRecord
  validates :employee_id, presence: true, numericality: true
  validates :controller, presence: true
  validates :action, presence: true
  validates :entity_id, presence: true, numericality: true
end
