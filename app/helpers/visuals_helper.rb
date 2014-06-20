module VisualsHelper


  def sti_visual_path(type = "visual", visual = nil, action = nil)
    send "#{format_sti(action, type, visual)}_path", visual
  end

  def format_sti(action, type, visual)
    action || visual ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end

  def format_action(action)
    action ? "#{action}_" : ""
  end

end
