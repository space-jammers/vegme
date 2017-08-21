module ApplicationHelper
  def foundation_class_for(flash_type)
    case flash_type
    when :success
      'success'
    when :error
      'alert'
    when :alert
      'warning'
    when :notice
      'primary'
    else
      'secondary'
    end
  end
end
