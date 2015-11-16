  // Place all the behaviors and hooks related to the matching controller here.
  // All this logic will automatically be available in application.js.
  // You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('ready page:load', function () {


    var targetDate =  $('.initial-date'),
        today = moment().toISOString();

    // format: "YYYY-MM-DD\THH:mm:ss\Z"
    targetDate.datetimepicker({
        sideBySide: true,
        format: "YYYY-MM-DD",
        maxDate: today,
        defaultDate: today
    });
    var crossButtons = new Crossbuttons({
        btns: [ 'bus_id', 'bus_license_plate']
    });
    crossButtons.init();
});