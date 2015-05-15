module BusesHelper
  def flash_import(flash)
    if !flash.blank?
      alert_type = ""
      color = ""
      if flash[:notice]
        alert_type = flash[:notice]
        color = "success"
      elsif flash[:alert]
        alert_type = flash[:alert]
        color = "warning"
      end
      return "<div class=\" alert alert-#{color}\" role=\"alert\">
              #{alert_type}
            </div>".html_safe
    end
  end
end
