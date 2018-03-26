module ApplicationHelper
  def render_page_tag?(page)
    page.left_outer? || page.right_outer? || page.inside_window?
  end
end
