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
    scoped = filter_by_client_phone_numbers(scoped, params[:client_phone_numbers])
    scoped = filter_by_responsible_employee(scoped, params[:responsible_employee])
    scoped = paginate(scoped, params[:page])
    scoped
  end

  private

  def filter_by_id(scoped, id = nil)
    id.present? ? scoped.where('estates.id = ?', id) : scoped
  end

  def filter_by_address(scoped, estate_city = nil, estate_street = nil, estate_building_number = nil)
    return scoped if address_fields_blank?(estate_city, estate_street, estate_building_number)

    if estate_building_number.blank?
      streets = if estate_street.blank?
                  Street.select(:id).where('`city_id` = ?', estate_city)
                else
                  Street.select(:id).where('`city_id` = ? AND `id` = ?', estate_city, estate_street)
                end

      addresses = Address.select(:id).where('`street_id` IN (?)', streets.to_a)
      scoped.where('`address_id` IN (?)', addresses.to_a)
    else
      street  = Street.select(:id).find_by(city_id: estate_city, id: estate_street)
      address = Address.select(:id).find_by(street_id: street.id, building_number: estate_building_number)
      scoped.where('`address_id` = ?', address ? address.id : 0)
    end
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

  def address_fields_blank?(estate_city = nil, estate_street = nil, estate_building_number = nil)
    estate_city.blank? && estate_street.blank? && estate_building_number.blank?
  end
end
