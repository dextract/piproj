module ContentsHelper

  def sti_content_path(type = "content", content = nil, action = nil)
    send "#{format_sti(action, type, content)}_path", content
  end

  def format_sti(action, type, content)
    action || content ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end

  def format_action(action)
    action ? "#{action}_" : ""
  end

end
