module BusRoutesHelper
  def flash_import(flash)
    if !flash.blank?
      alert_type = ""
      color = ""
      if flash[:notice]
        alert_type = flash[:notice]
        color = "success"
      elsif flash[:alert]
        alert_type = flash[:alert]
        color = "danger"
      end
      return "<div class=\"col-xs-offset-1 col-xs-8 alert alert-#{color}\" role=\"alert\">
              #{alert_type}
            </div>".html_safe
    end
  end
  def table_routes(bus_routes,counter = 0)
    if bus_routes.empty?
      return '<tr>
        <td>No hay datos que mostrar</td>
        <td>
          <table class="inner-table">
            <tbody>
             <td>-</td>
             <td>00:00</td>
             <td>-</td>
           </tbody>
         </table>
       </td>
      </tr>'.html_safe
    else
      html = ""
      bus_routes.each do |bus_route| 
        html += %Q[ <tr>
          <td>#{bus_route.name}</td> ]
        td_index = 0
        bus_route.trips.each do |trip|
          html += %Q[
            <td>
              <table class="inner-table">
                <tbody>
                 <td>#{direccion = trip.direction == "left" ? "I" : "D"}</td>
                 <td>#{trip.start_time.strftime "%I:%M:%S %p"}</td>
                 <td>#{trip.neighbourhood}</td>
               </tbody>
             </table>
           </td>
          ]
          td_index += 1
        end
        while td_index  < counter
          html += %Q[
            <td>
              <table class="inner-table">
                <tbody>
                 <td> - </td>
                 <td> - </td>
                 <td> - </td>
               </tbody>
             </table>
           </td>
          ]
          td_index += 1
        end
        html +=  "</tr>"
      end
      return html.html_safe
    end
  end
end
