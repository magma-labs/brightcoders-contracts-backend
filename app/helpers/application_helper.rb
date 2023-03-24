module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :success
      'success'
    when :error
      'danger'
    when :alert
      'warning'
    when :notice
      'info'
    else
      flash_type.to_s
    end
  end

  def render_flash_messages
    render partial: 'shared/flash_messages', locals: { messages: flash }
  end  
end
  