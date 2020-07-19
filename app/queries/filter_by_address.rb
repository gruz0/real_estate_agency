# frozen_string_literal: true

class FilterByAddress
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  # FIXME: It should be refactored with stripping all params values inside filters
  def call(estate_city, estate_street, estate_building_number)
    scoped = initial_scope
    filter(scoped, estate_city, estate_street, estate_building_number)
  end

  private

  def filter(scoped, estate_city = nil, estate_street = nil, estate_building_number = nil)
    return scoped if address_fields_blank?(estate_city, estate_street, estate_building_number)

    if estate_building_number.blank?
      filter_by_city_and_street(scoped, estate_city, estate_street)
    else
      filter_by_building_number(scoped, estate_city, estate_street, estate_building_number)
    end
  end

  def filter_by_city_and_street(scoped, estate_city, estate_street)
    streets = if estate_street.blank?
                Street.select(:id).where('`city_id` = ?', estate_city)
              else
                Street.select(:id).where('`city_id` = ? AND `id` = ?', estate_city, estate_street)
              end

    addresses = Address.select(:id).where('`street_id` IN (?)', streets.to_a)
    scoped.where('`address_id` IN (?)', addresses.to_a)
  end

  def filter_by_building_number(scoped, estate_city, estate_street, estate_building_number)
    street = Street.select(:id).find_by(city_id: estate_city, id: estate_street)
    address = Address.select(:id).find_by(street_id: street.id, building_number: estate_building_number)
    scoped.where('`address_id` = ?', address ? address.id : 0)
  end

  def address_fields_blank?(estate_city = nil, estate_street = nil, estate_building_number = nil)
    estate_city.blank? && estate_street.blank? && estate_building_number.blank?
  end
end
