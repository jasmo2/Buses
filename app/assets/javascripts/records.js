  // Place all the behaviors and hooks related to the matching controller here.
  // All this logic will automatically be available in application.js.
  // You can use CoffeeScript in this file: http://coffeescript.org/
function recordTable () {
  // Actions to do
    $('#records-table').DataTable({
        bLengthChange: false, 
        bFilter: false, 
        bInfo: false,
        "scrollX": true,
        "iDisplayLength": 60
      }
    );
};

$(document).on('ready page:load', function () {

    var initialDate = $('#initial-date-input'),
        targetDate =  $('.initial-date2'),
        tailTimeFormat="T03:00:00.000Z",
        today = moment().toISOString();
    initialDate.val (moment().format("YYYY-MM-DD")+tailTimeFormat);
    $('#final-date-input').val (today);
    // format: "YYYY-MM-DD\THH:mm:ss\Z"
    targetDate.datetimepicker({
        sideBySide: true,
        format: "YYYY-MM-DD",
        maxDate: today,
        defaultDate: moment().format("YYYY-MM-DD")+tailTimeFormat
    }).on('dp.change',function(e){
        initialDate.val(moment(e.date._i,'YYYY-MM-DD')+tailTimeFormat);
    });
    var crossButtons = new Crossbuttons({
        btns: [ 'bus_id', 'bus_license_plate']
    });
    crossButtons.init();
});