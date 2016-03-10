$(document).ready(function() {
	$('.form-control').focusout(function (e){
		email_field = $(this)
		email = $(this).val();
		email_attr = $(this).attr('name');
		if  ( email == ""){
			$(this).addClass('field_error');
			$('#email-validation').html("");
		}else{
			if (email_attr == "user[email]"){
				if (isEmail(email) == true){
					$.ajax({
				    url : "/validate_email",
				    type: "GET",
				    data : {email: email},
				    dataType: "JSON",
				    beforeSend: function() {
				    	$('#login_submit_btn').prop( "disabled", true );
				    },
				  }).done(function(response) {
				    if (response.success == true){
				    	email_field.removeClass('field_error');
				    	$('#email-validation').html("");
				    	$('#login_submit_btn').prop( "disabled", false );
				    }else{
				    	showFailureMessage(email_field, response.message)
				    }
				  });
				}else{
					message = "Invalid email!"
					showFailureMessage(email_field, message)
				}
				e.preventDefault();
			}else{
				email_field.removeClass('field_error');
			}
		}
	});

	function showFailureMessage(email_field, message){
  	email_field.addClass('field_error');
  	$('#email-validation').html(message)
  	$('#email-validation').css({opacity: 0});
  	$('#email-validation').animate({opacity: 1}, 700 );
  	$('#login_submit_btn').prop( "disabled", true );
	}

	function isEmail(email) {
  	var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  	return regex.test(email);
	}

});