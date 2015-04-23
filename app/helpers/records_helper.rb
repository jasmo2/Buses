module RecordsHelper
  def flash_records(flash)
    if !flash.blank?
      alert_type = ""
      color = ""
      if flash[:notice]
        alert_type = flash[:notice]
        color = "success"
      end 
      if flash[:alert]
        alert_type = flash[:alert]
        color = "danger"
      end
      return "<div class=\"alert alert-#{color} col-xs-7\" 
      role=\"alert\">#{alert_type}</div>".html_safe         
    end 
  end
end
