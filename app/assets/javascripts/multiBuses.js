/**
 * Created by jasmo2 on 11/17/15.
 */
(function(){
    $(document).on('ready page:load', function () {
        $('#multiple-buses-form').submit(function(e) {
            e.preventDefault();

            buses = new BusesRecords({
                $buses: $('input#buses_'),
                $buses_assignment:  $('input[name=buses_assignment]'),
                user_id: $("#user_id")
            });

            $.ajax({
                type: this.method.toUpperCase(),
                url: $(this).attr('action'), //sumbits it to the given url of the form
                data: JSON.parse(JSON.stringify(buses)),
                dataType: "json"

            })
                .success(function(json){
                    console.log("success", json);
                    $("#comunication-success").show();
                })
                .error(function(err){
                    console.log("error", err);

                });

            return false;
        })
    })
    function BusesRecords(obj){
        var  $buses_assignment = obj.$buses_assignment,
             user_id = obj.user_id.val(),
            buses_assignment = {} ;
        //Updating multiple records:
        //people = { 1 => { "first_name" => "David" }, 2 => { "first_name" => "Jeremy" } }

        $buses_assignment.each(function(){
            //isChecked =  this.checked ? this.value : "nil";
            belongsToUser = this.checked ? user_id : ""
            buses_assignment[this.id.toString()] = {user_id: belongsToUser};
        });

        return {buses_assignment: buses_assignment};
    }
})();