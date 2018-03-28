module ApplicationHelper
  def page_title(title)
    title.presence || t('views.layout.title')
  end

  def render_page_tag?(page)
    page.left_outer? || page.right_outer? || page.inside_window?
  end
end
