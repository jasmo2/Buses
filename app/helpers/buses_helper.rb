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

  def days_in_the_month
    actual_month = l Time.now, format: :short
    html = ""
    (Time.days_in_month(Time.now.to_date.month)).times do |day|  
      day += 1
      html += %Q[
        <th>#{actual_month.capitalize}-#{day}</th>
      ]
    end
    html.html_safe
  end
  def assigned_routes_to(bus)
    days_in_the_month = Time.days_in_month(Time.now.to_date.month)
    d = Date.today
    html = ""
    days_in_the_month.times do |day|
      day += 1
      schedualed_route = bus.operation_dates.where(operation_date: Date.new(d.year,d.month,day)).take
      if schedualed_route
        html += %Q[
          <td> #{schedualed_route.bus_route.name} </td>
        ]
      else
        html += %Q[
          <td> - </td>
        ]
      end
    end
      
    html.html_safe
  end
end
