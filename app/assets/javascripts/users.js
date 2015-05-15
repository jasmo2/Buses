var doc;

doc = $(document);

doc.on('ready page:load', function() {
  doc.on('click', '.subscription', function() {
    var $el;
    $el = $(this).siblings();
    if ($el.val() === 'true') {
      $el.val('false');
    } else {
      $el.val('true');
    }
  });
});
