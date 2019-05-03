class FindEstates
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  # FIXME: It should be refactored with stripping all params values inside filters
  def call(params)
    scoped = initial_scope
    scoped = filter_by_id(scoped, params[:id])
    scoped = filter_by_address(scoped, params[:estate_city], params[:estate_street], params[:estate_building_number])
    scoped = filter_by_estate_project(scoped, params[:estate_project])
    scoped = filter_by_number_of_rooms(scoped, params[:number_of_rooms])
    scoped = filter_by_floor(scoped, params[:floor_from], params[:floor_to])
    scoped = filter_by_price(scoped, params[:price_from], params[:price_to])
    scoped = filter_by_total_square_meters(scoped, params[:total_square_meters_from], params[:total_square_meters_to])
    scoped = filter_by_client_phone_numbers(scoped, params[:client_phone_numbers])
    scoped = filter_by_responsible_employee(scoped, params[:responsible_employee])
    scoped = filter_by_status(scoped, params[:status])
    scoped = paginate(scoped, params[:page])
    scoped
  end

  private

  def filter_by_id(scoped, id = nil)
    id.present? ? scoped.where('estates.id = ?', id) : scoped
  end

  def filter_by_address(scoped, estate_city = nil, estate_street = nil, estate_building_number = nil)
    FilterByAddress.new(scoped).call(estate_city, estate_street, estate_building_number)
  end

  def filter_by_estate_project(scoped, estate_project_id = nil)
    estate_project_id.present? ? scoped.where(estate_project_id: estate_project_id) : scoped
  end

  def filter_by_number_of_rooms(scoped, number_of_rooms = nil)
    number_of_rooms.present? ? scoped.where('estates.number_of_rooms = ?', number_of_rooms) : scoped
  end

  def filter_by_floor(scoped, floor_from = nil, floor_to = nil)
    filter_from_to(scoped, :floor, floor_from, floor_to)
  end

  def filter_by_price(scoped, price_from = nil, price_to = nil)
    filter_from_to(scoped, :price, price_from, price_to)
  end

  def filter_by_total_square_meters(scoped, total_square_meters_from = nil, total_square_meters_to = nil)
    filter_from_to(scoped, :total_square_meters, total_square_meters_from, total_square_meters_to)
  end

  def filter_by_client_phone_numbers(scoped, client_phone_numbers = nil)
    return scoped if client_phone_numbers.blank?
    scoped.where('estates.client_phone_numbers LIKE ?', "%#{client_phone_numbers}%")
  end

  def filter_by_responsible_employee(scoped, responsible_employee_id = nil)
    responsible_employee_id.present? ? scoped.where(responsible_employee_id: responsible_employee_id) : scoped
  end

  def filter_by_status(scoped, status = nil)
    status.present? ? scoped.where(status: status) : scoped
  end

  def paginate(scoped, page_number = 0)
    scoped.page(page_number)
  end

  def filter_from_to(scoped, column, from, to)
    return scoped if from.blank? && to.blank?

    if from.present?
      if to.present?
        scoped.where(estates: { column.to_sym => (from..to) })
      else
        scoped.where("estates.#{column} >= ?", from)
      end
    else
      scoped.where("estates.#{column} <= ?", to)
    end
  end
end
