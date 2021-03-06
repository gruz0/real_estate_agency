# frozen_string_literal: true

namespace :app do
  desc 'Creates default dictionaries'
  task initialize: :environment do
    %w[Квартира Дом Комната].each do |estate_type|
      EstateType.create!(name: estate_type)
    end

    %w[Уральский Саратовский Ленинградский].each do |estate_project|
      EstateProject.create!(name: estate_project)
    end

    %w[Панельный Заливной Кирпичный Деревянный].each do |estate_material|
      EstateMaterial.create!(name: estate_material)
    end

    ['Нефтеюганск'].each do |city|
      City.create!(name: city)
    end
  end
end
