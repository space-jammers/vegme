module ApplicationHelper
  def foundation_class_for(flash_type)
    case flash_type
    when 'success'
      'flash-success'
    when 'error'
      'flash-error'
    when 'alert'
      'flash-error'
    when 'notice'
      'flash-notice'
    else
      'flash-notice'
    end
  end

  def flash_icon_for(flash_type)
    case flash_type
    when 'success'
      'fa-check-circle'
    when 'error'
      'fa-exclamation-circle'
    when 'alert'
      'fa-exclamation-circle'
    when 'notice'
      'fa-info-circle'
    else
      'fa-info-circle'
    end
  end
end
