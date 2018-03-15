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
      expect(find_estates.to_sql).to include('estates.id = 42')
    end

    it 'returns query with #filter_by_estate_project' do
      params[:estate_project] = 42
      expect(find_estates.to_sql).to include('`estates`.`estate_project_id` = 42')
    end

    it 'returns query with #filter_by_number_of_rooms' do
      params[:number_of_rooms] = 42
      expect(find_estates.to_sql).to include('estates.number_of_rooms = 42')
    end

    it 'returns query with #filter_by_floor_from' do
      params[:floor_from] = 42
      expect(find_estates.to_sql).to include('estates.floor >= 42')
    end

    it 'returns query with #filter_by_floor_to' do
      params[:floor_to] = 42
      expect(find_estates.to_sql).to include('estates.floor <= 42')
    end

    it 'returns query with #filter_by_floor_from and #filter_by_floor_to' do
      params[:floor_from] = 35
      params[:floor_to] = 42
      expect(find_estates.to_sql).to include('(estates.floor >= 35 AND estates.floor <= 42)')
    end

    it 'returns query with #filter_by_price_from' do
      params[:price_from] = 42
      expect(find_estates.to_sql).to include('estates.price >= 42')
    end

    it 'returns query with #filter_by_price_to' do
      params[:price_to] = 42
      expect(find_estates.to_sql).to include('estates.price <= 42')
    end

    it 'returns query with #filter_by_price_from and #filter_by_price_to' do
      params[:price_from] = 35
      params[:price_to] = 42
      expect(find_estates.to_sql).to include('(estates.price >= 35 AND estates.price <= 42)')
    end

    it 'returns query with #filter_by_client_phone_numbers' do
      params[:client_phone_numbers] = '999'
      expect(find_estates.to_sql).to include("estates.client_phone_numbers LIKE '%999%'")
    end

    it 'returns query with #filter_by_responsible_employee' do
      params[:responsible_employee] = 42
      expect(find_estates.to_sql).to include('`estates`.`responsible_employee_id` = 42')
    end
  end
end
