  // Place all the behaviors and hooks related to the matching controller here.
  // All this logic will automatically be available in application.js.
  // You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function() {
    // $.fn.dataTableExt.sErrMode = 'throw';
    $('#bus-route-table').DataTable(
      {
        bLengthChange: false, bFilter: false, bInfo: false
      }
    );
    $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
           var input = $(this).parents('.input-group').find(':text'),
               log = numFiles > 1 ? numFiles + ' files selected' : label;
           if( input.length ) {
               input.val(log);
           }
       });
    $(document).on('change', '.btn-file :file', function() {
        var input = $(this),
            numFiles = input.get(0).files ? input.get(0).files.length : 1,
            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        input.trigger('fileselect', [numFiles, label]);
    });
} );