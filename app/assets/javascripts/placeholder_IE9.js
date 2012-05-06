 $(function() {
  //Run this script only for IE
  if (navigator.appName === "Microsoft Internet Explorer") {
    $("input[type=text]").each(function() {
      var p;
     // Run this script only for input field with placeholder attribute
      if (p = $(this).attr('placeholder')) {
      // Input field's value attribute gets the placeholder value.
        $(this).val(p);
        $(this).css('color', '#B0B0B0');
        // On selecting the field, if value is the same as placeholder, it should become blank
        $(this).focus(function() {
          if (p === $(this).val()) {
            return $(this).val('');
          }
        });
         // On exiting field, if value is blank, it should be assigned the value of placeholder
        $(this).blur(function() {
          if ($(this).val() === '') {
            return $(this).val(p);
          }
        });
      }
    });
    $("input[type=password]").each(function() {
      var e_id, p;
      if (p = $(this).attr('placeholder')) {
        e_id = $(this).attr('id');
        // change input type so that the text is displayed
        document.getElementById(e_id).type = 'text';
        $(this).val(p);
        $(this).focus(function() {
          // change input type so that password is not displayed
          document.getElementById(e_id).type = 'password';
          if (p === $(this).val()) {
            return $(this).val('');
          }
        });
        $(this).blur(function() {
          if ($(this).val() === '') {
            document.getElementById(e_id).type = 'text';
            $(this).val(p);
          }
        });
      }
    });
    $('form').submit(function() {
      //Interrupt submission to blank out input fields with placeholder values
      $("input[type=text]").each(function() {
        if ($(this).val() === $(this).attr('placeholder')) {
          $(this).val('');
        }
      });
     $("input[type=password]").each(function() {
        if ($(this).val() === $(this).attr('placeholder')) {
           $(this).val('');
        }
      });
    });
  }
});