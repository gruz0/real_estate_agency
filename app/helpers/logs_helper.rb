module LogsHelper
  def row_class_depends_on_log_message(log)
    log.error_messages.blank? ? '' : 'table-danger'
  end
end
