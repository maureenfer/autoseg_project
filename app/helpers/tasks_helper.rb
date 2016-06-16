module TasksHelper
  def sti_task_path(type = "task", task = nil, action = nil)
    send "#{format_sti(action, type, task)}_path", task
  end
   
  def format_sti(action, type, task)
    action || task ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end
   
  def format_action(action)
    action ? "#{action}_" : ""
  end
end
