formValidation = function () {

  $("#bus-form").validate({
    rules: {
      "bus[id]": {
          required: true,
          number: true
        },
      "bus[plate_license]": {
        required: true,
        minlength: 6
      },
      "bus[driver_name]": {required: true}
    },
    messages: {
      "bus[id]": {
        number: "Ingresar un número",
        required: "Campo requerido"
      },
      "bus[plate_license]": {
        rangelength: "Ingresar una placa de 6 caracteres sin espacio",
        required: "Campo requerido"
      },
      "bus[driver_name]": {
        required: "Ingresar nombre"
      }
    },
        
    submitHandler: function(form) {
      form.submit();
    }
  });

}