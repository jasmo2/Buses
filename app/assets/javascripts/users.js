var doc;

doc = $(document);

doc.on('ready page:load', function() {
  doc.on('click', '.subscription', function() {
    var $hidden_sibling;
    var $checkbox_sibling =  $(this);
    $hidden_sibling = $checkbox_sibling.siblings();

    if ($hidden_sibling.val() === "nil") {
      $hidden_sibling.val($checkbox_sibling.attr("id"))
    } else {
      $hidden_sibling.val("nil");
    }
  });
});
