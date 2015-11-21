  // Place all the behaviors and hooks related to the matching controller here.
  // All this logic will automatically be available in application.js.
  // You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('ready page:load', function () {
    var targetDate =  $('.initial-date'),
        today = moment().toISOString();
        $progresBar = $("#passenger_wrapper .progress"),
        $passangerInfo =  $("#passenger-info");

    // format: "YYYY-MM-DD\THH:mm:ss\Z"
    targetDate.datetimepicker({
        ignoreReadonly: true,
        sideBySide: true,
        format: "YYYY-MM-DD",
        maxDate: today,
        defaultDate: today
    });
    var crossButtons = new Crossbuttons({
        btns: [ 'bus_id', 'bus_license_plate']
    });
    crossButtons.init();
    $('#passenger-quantity-form').submit(function() {
        $passangerInfo.hide();
        $progresBar.show();
        this.disabled = true
        var valuesToSubmit = $(this).serialize();
        $.ajax({
            type: this.method.toUpperCase(),
            url: $(this).attr('action'), //sumbits it to the given url of the form
            data: valuesToSubmit
        })
            .success(function(json){
                console.log("success", json);
            })
            .error(function(err){
                console.log("error", err);
                $("#comunication-error").show();
            })
            .always(function(){
                $("#passenger_wrapper .progress").hide();
                document.getElementById("passenger-quantity").disabled = false;
            });
        return false; // prevents
    })
});