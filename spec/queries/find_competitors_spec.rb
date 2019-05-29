require 'rails_helper'

RSpec.describe FindCompetitors do
  let(:find_competitors) { described_class.new(initial_scope).call(params) }
  let(:initial_scope) { Competitor.all }
  let(:params) { {} }

  context 'with empty params' do
    it 'paginates' do
      expect(find_competitors.to_sql).to include('LIMIT')
      expect(find_competitors.to_sql).to include('OFFSET')
    end
  end

  context 'with filters' do
    it 'returns query with #filter_by_phone_numbers' do
      params[:phone_numbers] = '999'
      expect(find_competitors.to_sql).to include("competitors.phone_numbers LIKE '%999%'")
    end
  end
end
