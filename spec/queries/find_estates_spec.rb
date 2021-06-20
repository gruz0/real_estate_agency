# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FindEstates do
  let(:find_estates) { described_class.new(initial_scope).call(params) }
  let(:initial_scope) { Estate.all }
  let(:params) { {} }

  context 'with empty params' do
    it 'paginates' do
      expect(find_estates.to_sql).to include('LIMIT')
      expect(find_estates.to_sql).to include('OFFSET')
    end
  end

  context 'with filters' do
    it 'returns query with #filter_by_id' do
      params[:id] = 42
      expect(find_estates.to_sql).to include('`estates`.`id` = 42')
    end

    describe '#filter_by_address' do
      let(:city) { create(:city) }
      let(:street) { create(:street, city: city) }
      let(:address1) { create(:address, street: street) }
      let(:address2) { create(:address, street: street, building_number: '123') }

      context 'when all fields filled' do
        it 'returns query' do
          params[:estate_city] = city.id
          params[:estate_street] = street.id
          params[:estate_building_number] = address2.building_number

          expect(find_estates.to_sql).to include("`address_id` = #{address2.id}")
        end
      end

      context 'when building_number was not filled' do
        it 'returns query' do
          address1
          address2

          params[:estate_city] = city.id
          params[:estate_street] = street.id

          expect(find_estates.to_sql).to include("`address_id` IN (#{address1.id},#{address2.id})")
        end
      end

      context 'when estate_street was not filled' do
        it 'returns query' do
          address1
          address2

          params[:estate_city] = city.id

          expect(find_estates.to_sql).to include("`address_id` IN (#{address1.id},#{address2.id})")
        end
      end

      context 'when all fields are empty' do
        it 'returns query without condition' do
          expect(find_estates.to_sql).not_to include('`address_id`')
        end
      end
    end

    it 'returns query with #filter_by_estate_project' do
      params[:estate_project] = 42
      expect(find_estates.to_sql).to include('`estates`.`estate_project_id` = 42')
    end

    it 'returns query with #filter_by_number_of_rooms' do
      params[:number_of_rooms] = 42
      expect(find_estates.to_sql).to include('`estates`.`number_of_rooms` = 42')
    end

    it 'returns query with #filter_by_floor_from' do
      params[:floor_from] = 42
      expect(find_estates.to_sql).to include('`estates`.`floor` >= 42')
    end

    it 'returns query with #filter_by_floor_to' do
      params[:floor_to] = 42
      expect(find_estates.to_sql).to include('`estates`.`floor` <= 42')
    end

    it 'returns query with #filter_by_floor_from and #filter_by_floor_to' do
      params[:floor_from] = 35
      params[:floor_to] = 42
      expect(find_estates.to_sql).to include('`estates`.`floor` BETWEEN 35 AND 42')
    end

    it 'returns query with #filter_by_price_from' do
      params[:price_from] = 42
      expect(find_estates.to_sql).to include('`estates`.`price` >= 42')
    end

    it 'returns query with #filter_by_price_to' do
      params[:price_to] = 42
      expect(find_estates.to_sql).to include('`estates`.`price` <= 42')
    end

    it 'returns query with #filter_by_price_from and #filter_by_price_to' do
      params[:price_from] = 35
      params[:price_to] = 42
      expect(find_estates.to_sql).to include('`estates`.`price` BETWEEN 35 AND 42')
    end

    it 'returns query with #filter_by_total_square_meters_from' do
      params[:total_square_meters_from] = 42
      expect(find_estates.to_sql).to include('`estates`.`total_square_meters` >= 42')
    end

    it 'returns query with #filter_by_total_square_meters_to' do
      params[:total_square_meters_to] = 42
      expect(find_estates.to_sql).to include('`estates`.`total_square_meters` <= 42')
    end

    it 'returns query with #filter_by_total_square_meters_from and #filter_by_total_square_meters_to' do
      params[:total_square_meters_from] = 35
      params[:total_square_meters_to] = 42
      expect(find_estates.to_sql).to include('`estates`.`total_square_meters` BETWEEN 35.0 AND 42.0')
    end

    it 'returns query with #filter_by_client_phone_numbers' do
      params[:client_phone_numbers] = '999'
      expect(find_estates.to_sql).to include("estates.client_phone_numbers LIKE '%999%'")
    end

    it 'returns query with #filter_by_responsible_employee' do
      params[:responsible_employee] = 42
      expect(find_estates.to_sql).to include('`estates`.`responsible_employee_id` = 42')
    end

    it 'returns query with #filter_by_status' do
      params[:status] = :delayed
      expect(find_estates.to_sql).to include('`estates`.`status` = 2')
    end
  end
end
