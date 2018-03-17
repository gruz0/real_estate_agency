module LogsHelper
  def row_class_depends_on_log_message(log)
    log.error_messages.blank? ? '' : 'table-danger'
  end

  def render_log_message_for(log)
    log.error_messages.presence || log.flash_notice
  end
end
