namespace :import do
  desc 'Import estates from LeaderCom'
  task leadercom: :environment do
    include PeopleHelper

    DatabaseCleaner.clean_with(:truncation)

    city_id = City.create!(name: 'Нефтеюганск')

    #
    # Streets
    #
    STREETS = [# {{{
      '1-й мкр', '2-й мкр', '3-й мкр', '4-й мкр', '5-й мкр', '6-й мкр', '7-й мкр', '8-й мкр', '8а мкр',
      '9-й мкр', '9а мкр', '10-й мкр', '10а мкр', '11-й мкр', '11а мкр', '11б мкр', '12-й мкр', '13-й мкр',
      '14-й мкр', '15-й мкр', '16-й мкр', '16а мкр', '17-й мкр', 'Жилая', 'Мартовская', 'Спортивная', 'Гагарина',
      'Петухова', 'СУ-62', 'УМ 4', 'Сингапай'
    ].freeze

    STREETS_DOWNCASED = STREETS.map { |s| s.mb_chars.strip.downcase }.freeze

    streets_mapping = {}
    STREETS.each do |street|
      s = Street.create!(city: city_id, name: street)
      streets_mapping[street] = s.id
    end# }}}

    #
    # EstateTypes
    #
    ESTATE_TYPES = {# {{{
      '509' => 'Квартира'
    }.freeze

    estate_types_mapping = {}
    ESTATE_TYPES.each do |key, value|
      et = EstateType.create!(name: value)
      estate_types_mapping[key] = et.id
    end# }}}

    #
    # EstateProjectTypes
    #
    ESTATE_PROJECTS = {# {{{
      '801' => 'Старый',
      '802' => 'Сталинка',
      '803' => 'Хрущёвка',
      '804' => 'Новый',
      '805' => 'Новостройка',
      '806' => 'Волгоградский',
      '807' => 'Московский',
      '809' => 'Улучшенный',
      '810' => 'Брежневка',
      '812' => 'Малосемейка',
      '813' => 'Общежитие',
      '814' => 'Коммуналка',
      '816' => 'Элитный',
      '817' => 'Частный застройщик'
    }.freeze

    estate_projects_mapping = {}
    ESTATE_PROJECTS.each do |key, value|
      ep = EstateProject.create!(name: value)
      estate_projects_mapping[key] = ep.id
    end# }}}

    #
    # EstateMaterials
    #
    ESTATE_MATERIALS = {# {{{
      '301' => 'Кирпичный',
      '302' => 'Панельный',
      '303' => 'Монолитный',
      '304' => 'Панельно-кирпичный',
      '307' => 'Деревянный',
      '308' => 'Каркасно-монолитный',
      '309' => 'Блочный',
      '310' => 'Бревенчатый',
      '313' => 'Пеноблочный',
      '315' => 'Брусчатый'
    }.freeze

    estate_materials_mapping = {}
    ESTATE_MATERIALS.each do |key, value|
      em = EstateMaterial.create!(name: value)
      estate_materials_mapping[key] = em.id
    end# }}}

    #
    # Parsing
    #
    require 'nokogiri'

    doc = Nokogiri::XML.parse(File.open('tmp/dump.xml'))

    #
    # Cities
    #
    city = 'nkwb46Oa7k+CFvsGUmkhxA'

    #
    # Companies
    #
    companies = parse_companies(doc, city)

    #
    # Employees
    #
    employees = parse_employees(doc, companies.first[:sid])# {{{

    employees_mapping = {}
    employees.each_with_index do |employee, idx|
      e = Employee.create!(
        email: employee[:email] || "user#{idx}@example.com",
        password: 'password',
        last_name: employee[:last_name],
        first_name: employee.fetch(:first_name, nil) || 'Не заполнено',
        middle_name: employee[:middle_name],
        phone_numbers: employee[:phones]
      )

      employees_mapping[employee[:sid]] = {
        employee_id: e.id,
        short_name: person_shortname(e)
      }
    end# }}}

    #
    # Clients
    #
    clients = parse_clients(doc, companies.first[:sid])# {{{

    clients_mapping = {}
    clients.each do |client|
      clients_mapping[client[:sid]] = {
        full_name: client[:full_name] ? client[:full_name] : 'Не заполнено',
        phone_numbers: client[:phones].to_s.split(',')
      }
    end# }}}

    #
    # Estates
    #
    estates = parse_estates(doc, city, companies.first[:sid])

    invalid_estates = estates.map do |estate|
      message = []

      street = estate[:street]
      if street.blank?
        message << 'Не указана улица'
      else
        street = street.gsub(/^ул.\s+/, '').downcase
        street = case street
                 when '1'
                   '1-й мкр'
                 when '7'
                   '7-й мкр'
                 when '9'
                   '9-й мкр'
                 when '11 а'
                   '11а мкр'
                 when '11б'
                   '11б мкр'
                 when '16 мкр'
                   '16-й мкр'
                 when '16 а'
                   '16а мкр'
                 when 'су 62'
                   'су-62'
                 when 'ум-4'
                   'ум 4'
                 else
                   street
                 end

        if !STREETS_DOWNCASED.include?(street)
          message << "Неизвестное название улицы '#{street}'. Как должно быть: '1-й мкр', '9А мкр', 'Спортивная'"
        end
      end

      message << 'Не указан номер дома' if estate[:building_number].blank?

      if estate[:price].blank?
        message << 'Не указана стоимость'
      elsif estate[:price].size > 5
        message << 'Слишком большая стоимость. Пример корректной стоимости: 2100 = 2 млн. 100 тыс.'
      end

      estate_project = estate[:estate_project]
      unless estate_project.blank?
        if estate_project[:found]
          estate[:estate_project] = estate_project[:value]
        else
          message << "Неизвестный идентификатор проекта: #{estate_project[:value]}"
          estate[:estate_project] = 'Не найден'
        end
      end

      estate_material = estate[:estate_material]
      unless estate_material.blank?
        if estate_material[:found]
          estate[:estate_material] = estate_material[:value]
        else
          message << "Неизвестный идентификатор материала строения: #{estate_material[:value]}"
          estate[:estate_material] = 'Не найден'
        end
      end

      client = clients_mapping[estate[:client]]
      if client[:phone_numbers].blank?
        message << 'Не указан телефон клиента'
      else
        client[:phone_numbers].each do |phone_number|
          if phone_number =~ /\A[\+\d]+\z/
            if phone_number.size > 11
              message << "Слишком длинный номер телефона: #{phone_number}"
            end
          else
            message << "Некорректный формат телефона: #{phone_number}"
          end
        end
      end

      estate.merge(message: message)
    end.delete_if { |estate| estate[:message].blank? }

    unless invalid_estates.size.zero?
      #
      # Generate CSV
      #
      headers = invalid_estates.first.keys
      headers.delete(:sid)
      headers.delete(:estate_type)
      headers.delete(:created_at)
      headers.delete(:updated_at)
      headers.delete(:description)
      headers.push(:description)
      csv = headers.join(';') + "\n"

      invalid_estates.each do |estate|
        client = clients_mapping[estate[:client]]
        employee = employees_mapping[estate[:employee]]

        csv << [
          estate[:object_id],
          "#{client[:full_name]}, #{client[:phone_numbers]}",
          employee[:short_name],
          estate[:street],
          estate[:building_number],
          estate[:apartment_number],
          estate[:number_of_rooms],
          estate[:floor],
          estate[:number_of_floors],
          estate[:total_square_meters],
          estate[:kitchen_square_meters],
          estate[:estate_material],
          estate[:estate_project],
          estate[:price],
          estate[:message].join(', '),
          estate[:description]
        ].join(';') + "\n"
      end

      File.write('tmp/output.csv', csv)

      puts "Invalid estates successfully exported to `tmp/output.csv`"
      abort
    end

    total_estates = invalid_estates.size
    cnt = 0

    invalid_estates.each do |item|
      cnt += 1
      sid       = item[:sid]
      object_id = item[:object_id]

      puts "--- Processing #{object_id} (#{cnt}/#{total_estates}) ---"

      street = Street.find_by_id(streets_mapping[item[:street].to_s])
      address = Address.find_or_create_by(street: street, building_number: item[:building_number])

      item[:client]               = Client.find_by_id(clients_mapping[item[:client]])
      item[:address]              = address
      item[:created_by_employee]  = Employee.find_by_id(employees_mapping[item[:employee]])
      item[:responsible_employee] = Employee.find_by_id(employees_mapping[item[:employee]])
      item[:estate_type]          = EstateType.all.sample
      item[:estate_material]      = EstateMaterial.all.sample
      item[:estate_project]       = EstateProject.all.sample
      item[:price]                = item[:price].to_i
      item[:created_at]           = item[:created_at].to_datetime
      item[:updated_at]           = item[:updated_at].to_datetime

      item.delete_if { |field| field.in?([:sid, :object_id, :employee, :street, :building_number, :message]) }

      estate = Estate.new(item)
      if estate.valid?
        estate.save!
      else
        puts ""
        puts "--- В объекте #{object_id} (#{sid}) обнаружены ошибки: ---"
        estate.errors.full_messages.each do |error|
          puts "* #{error}"
        end
      end
    end

    # puts JSON.pretty_generate(invalid_estates.first(10))
  end

  def parse_companies(doc, city)# {{{
    doc.xpath('//SystemOrganizations').map do |node|
      next {} unless node.xpath('SID_CITY').text.eql?(city)

      {
        sid: strip_node_text(node, 'SID'),
        name: strip_node_text(node, 'NAME')
      }
    end.delete_if(&:blank?)
  end# }}}

  def parse_employees(doc, company)# {{{
    doc.xpath('//SystemAdministrationUser').map do |node|
      next {} unless node.xpath('SID_ORGANIZATION').text.eql?(company)

      phones = clean_phones([
        strip_node_text(node, 'PHONEMOBILE'),
        strip_node_text(node, 'PHONEWORK'),
        strip_node_text(node, 'PHONE_HOME')
      ])

      last_name   = strip_node_text(node, 'SURNAME')
      first_name  = strip_node_text(node, 'NAME')
      middle_name = strip_node_text(node, 'SECNAME')
      email       = strip_node_text(node, 'EMAIL')

      {
        sid: strip_node_text(node, 'SID'),
        last_name: last_name.presence,
        first_name: first_name.presence,
        middle_name: middle_name.presence,
        phones: phones.presence,
        email: email.presence
      }
    end.delete_if(&:blank?)
  end# }}}

  def parse_clients(doc, company)# {{{
    doc.xpath('//CatalogueClients').map do |node|
      next {} unless node.xpath('SID_ORGANIZATION').text.eql?(company)

      phones = clean_phones([
        strip_node_text(node, 'PHONE_WORK'),
        strip_node_text(node, 'PHONE_HOME'),
        strip_node_text(node, 'PHONE_MOB'),
        strip_node_text(node, 'PHONE_MOB2')
      ])

      {
        sid: strip_node_text(node, 'SID'),
        full_name: strip_node_text(node, 'CLI_FIO').mb_chars.split.map(&:capitalize).join(' ').strip.presence,
        phones: phones.presence
      }
    end.delete_if(&:blank?)
  end# }}}

  def parse_estates(doc, city, company)# {{{
    doc.xpath('//CatalogueSaleApartament').map do |node|
      next {} unless node.xpath('SID_CITY').text.eql?(city)
      next {} unless node.xpath('SID_ORGANIZATION').text.eql?(company)

      apartment_number      = strip_node_text(node, 'FLAT').to_i
      number_of_rooms       = strip_node_text(node, 'ROOMS').to_i
      floor                 = strip_node_text(node, 'FLOOR').to_i
      number_of_floors      = strip_node_text(node, 'FLOORS').to_i
      total_square_meters   = strip_node_text(node, 'AREA_TOTAL').to_i
      kitchen_square_meters = strip_node_text(node, 'AREA_KITCHEN').to_i
      price                 = strip_node_text(node, 'COST').to_i

      estate_material = strip_node_text(node, 'HOUSE_WALL')
      estate_material = if estate_material.to_i.zero?
                          nil
                        elsif ESTATE_MATERIALS[estate_material]
                          {
                            found: true,
                            value: ESTATE_MATERIALS[estate_material]
                          }
                        else
                          {
                            found: false,
                            value: estate_material
                          }
                        end

      estate_project = strip_node_text(node, 'ID_FOND')
      estate_project = if estate_project.to_i.zero?
                         nil
                       elsif ESTATE_PROJECTS[estate_project]
                         {
                           found: true,
                           value: ESTATE_PROJECTS[estate_project]
                         }
                       else
                         {
                           found: false,
                           value: estate_project
                         }
                       end

      {
        sid: strip_node_text(node, 'SID'),
        object_id: node.xpath('CAT_NUM').text,
        client: node.xpath('SID_CLT').text,
        employee: node.xpath('SID_AGENT').text,
        street: strip_node_text(node, 'STREET').mb_chars.downcase.to_s,
        building_number: strip_node_text(node, 'HOUNUM'),
        apartment_number: apartment_number.zero? ? nil : apartment_number,
        number_of_rooms: number_of_rooms.zero? ? nil : number_of_rooms,
        floor: floor.zero? ? nil : floor,
        number_of_floors: number_of_floors.zero? ? nil : number_of_floors,
        total_square_meters: total_square_meters.zero? ? nil : total_square_meters,
        kitchen_square_meters: kitchen_square_meters.zero? ? nil : kitchen_square_meters,
        description: strip_node_text(node, 'NOTE').squish,
        estate_type: 'Квартира',
        estate_material: estate_material,
        estate_project: estate_project,
        price: price.zero? ? nil : price.to_s,
        created_at: Time.parse(node.xpath('CREA_TST').text),
        updated_at: Time.parse(node.xpath('MODI_TST').text)
      }
    end.delete_if(&:blank?)
  end# }}}

  private

  def strip_node_text(node, key)# {{{
    node.xpath(key).text.strip
  end# }}}

  def clean_phones(phones)# {{{
    phones.delete_if(&:blank?).map do |phone|
      p = phone.tr(' .()', '')
      p = '83463' + p if p.size == 6
      p.sub!(/^7/, '8')
      p
    end.join(',').strip
  end# }}}
end
