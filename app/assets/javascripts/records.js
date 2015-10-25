  // Place all the behaviors and hooks related to the matching controller here.
  // All this logic will automatically be available in application.js.
  // You can use CoffeeScript in this file: http://coffeescript.org/
var recordTable = function () {
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
  // recordTable();
  $('#initial-date').datetimepicker({sideBySide: true});
  $('#final-date').datetimepicker({sideBySide: true});
});