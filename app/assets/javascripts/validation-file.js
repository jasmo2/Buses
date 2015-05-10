validationFile = function(){
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
  $('.btn.btn-primary').on('click', function () {
    $('body').modalmanager('loading');
  })
};