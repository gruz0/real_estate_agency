class FindCompetitors
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def call(params)
    scoped = initial_scope
    scoped = filter_by_phone_numbers(scoped, params[:phone_numbers])
    scoped = paginate(scoped, params[:page])
    scoped
  end

  private

  def filter_by_phone_numbers(scoped, phone_numbers = nil)
    return scoped if phone_numbers.blank?

    scoped.where('competitors.phone_numbers LIKE ?', "%#{phone_numbers}%")
  end

  def paginate(scoped, page_number = 0)
    scoped.page(page_number)
  end
end
