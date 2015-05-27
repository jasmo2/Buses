  // Place all the behaviors and hooks related to the matching controller here.
  // All this logic will automatically be available in application.js.
  // You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('ready page:load', function () {
  // Actions to do
    $('#bus-route-table').DataTable(
      {
        bLengthChange: false,
        bFilter: false, 
        bInfo: false,
        "scrollX": true,
        "iDisplayLength": 60
      }
    );
    validationFile();
} );