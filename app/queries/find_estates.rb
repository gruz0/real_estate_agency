class FindEstates
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def call(params)
    scoped = initial_scope
    scoped = filter_by_id(scoped, params[:id])
    scoped = filter_by_estate_project(scoped, params[:estate_project])
    scoped = filter_by_number_of_rooms(scoped, params[:number_of_rooms])
    scoped = filter_by_floor(scoped, params[:floor])
    scoped = filter_by_price_to(scoped, params[:price_to])
    scoped = filter_by_client_phone_numbers(scoped, params[:client_phone_numbers])
    scoped = filter_by_responsible_employee(scoped, params[:responsible_employee])
    scoped = paginate(scoped, params[:page])
    scoped
  end

  private

  def filter_by_id(scoped, id = nil)
    id.present? ? scoped.where('estates.id = ?', id) : scoped
  end

  def filter_by_estate_project(scoped, estate_project_id = nil)
    estate_project_id.present? ? scoped.where(estate_project_id: estate_project_id) : scoped
  end

  def filter_by_number_of_rooms(scoped, number_of_rooms = nil)
    number_of_rooms.present? ? scoped.where('estates.number_of_rooms = ?', number_of_rooms) : scoped
  end

  def filter_by_floor(scoped, floor = nil)
    floor.present? ? scoped.where('estates.floor = ?', floor) : scoped
  end

  def filter_by_price_to(scoped, price_to = nil)
    price_to.present? ? scoped.where('estates.price <= ?', price_to) : scoped
  end

  def filter_by_client_phone_numbers(scoped, client_phone_numbers = nil)
    return scoped if client_phone_numbers.blank?
    scoped.where('estates.client_phone_numbers LIKE ?', "%#{client_phone_numbers}%")
  end

  def filter_by_responsible_employee(scoped, responsible_employee_id = nil)
    responsible_employee_id.present? ? scoped.where(responsible_employee_id: responsible_employee_id) : scoped
  end

  def paginate(scoped, page_number = 0)
    scoped.page(page_number)
  end
end
