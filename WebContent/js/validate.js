// agrega las validaciones a los diferentes campos de los 2 formularios
function addValidatesAccess() {
	$('#signup input[type="password"]').blur(validarPasswords);
	$('#email_signup').blur(validarEmail);
	$('#btn_signup').click(submitSignup);
	$('#btn_login').click(submitLogin);
}

// valida el registro de usuario antes de hacer submit
function submitSignup() {
	count = 0;
	if (!validarEmpty("user_signup", "El usuario no puede estar vacío")) count+=1;
	if (!validarPasswords()) count+=1;
	if (!validarEmail()) count+=1;
	if (!validarEdad()) count+=1;
	if (!validarBarrio("distric_signup")) count+=1;
	if (!validarHobbies("hobbies_signup")) count+=1;
	if (count == 0) { 
		var _hobbies = []
		var __hobbies = $('input[type=checkbox][name=hobbies_signup]:checked')
		$.each(__hobbies, function(i, value){
			_hobbies.push($(value).val());
		})

		$.post("signup", {
			user: $("#user_signup").val(),
			pwd: $("#pwd_signup_1").val(),
			email: $('#email_signup').val(),
			age: $('#age_signup').val(),
			distric: $('#distric_signup').val(),
			hobbies: _hobbies
		})
		/* 
		 * respuestas:
		 *  0: correcto
		 *  1: usuario repetido
		 *  2: correo repetido
		 */
		.done(function(respuesta, status){
			console.log("llega done");
			if (respuesta == 1) {
				$('#user_signup').parent().next().empty().append(makeAlert("alert-danger","Ese nombre de usuario ya está en uso", true));
			} else if (respuesta == 2) {
				$('#email_signup').parent().next().empty().append(makeAlert("alert-danger","Ese email ya está en uso", true));
			} else
				$(location).attr('href',"./");
		})
		.fail(function(xhr, status, error){
			$("#error_signup").empty().append(makeAlert("alert-danger","Error al conectar con el servidor", true));
		});
	}
}

// valida los datos de inicio antes de hacer submit()
function submitLogin(){
	$.post("login", {
		user: $("#user_login").val(),
		pwd: $("#pwd_login").val(),
		remember:$('#switch_login').prop('checked')
	})
	.done(function(respuesta, status){
		if (respuesta == 1)
			$(location).attr('href',"./");
    	else
    		$("#error_login").empty().append(makeAlert("alert-danger","Usuario o contraseña incorrecta", true));
    })
	.fail(function(xhr, status, error){
		$("#error_login").empty().append(makeAlert("alert-danger","Error al conectar con el servidor", true));
	});
}

function addValidatesCrearEvento() {
	$("#btn_submit").click(submitEvento);
}

function submitEvento() {
	count = 0;
	if (!validarFecha("fecha")) count +=1;
	if (!validarBarrio("barrio")) count+=1;
	if (!validarHobbies("hobbies")) count+=1;
	if (!validarEmpty("titulo", "El titulo no puede estar vacío")) count+=1;
	if (!validarEmpty("direccion", "La direccion no puede estar vacía")) count+=1;
	if (!validarEmpty("descripcion", "La descripcion no puede estar vacía")) count+=1;
	if (!validarHobbies("hobbies")) count+=1;
	if (count == 0) { 
		$("#btn_submit").attr("type","submit");
	}
}

function validarFecha(id){
	var inputFecha = $("#"+id);
	inputFecha.parent().next().empty();
	if (inputFecha.val() == ""){
		inputFecha.parent().next().append(makeAlert("alert-danger","Debe elegir una fecha", true));
		return false;
	}
	var fecha = new Date($('#'+id).val());
	var fechaMin = new Date();
	fechaMin.setDate(fechaMin.getDate() + 1);
	if (fecha < fechaMin){
		inputFecha.parent().next().append(makeAlert("alert-danger","La fecha debe ser como minimo dentro de 24h", true));
		return false;
	}
	return true;
}

function validarEmpty(id, mensaje) {
	var user = $('#'+id);
	if (user.val() == ""){
		user.parent().next().empty().append(makeAlert("alert-danger",mensaje, true));
		return false;
	}
	return true;
}
function validarPasswords() {
	var pwd1 = $('#pwd_signup_1');
	var pwd2 = $('#pwd_signup_2');

	/*
	 * '$(this).attr("id") == undefined' lo uso para indicar que la funcion inicie solo al pulsar el boton de registro
	 * porque cuando se ejecuta desde el blur del input this si tiene id
	 */
	if ($(this).attr("id") == undefined &&  pwd1.val() == "" && pwd2.val() == "") {
		pwd1.parent().next().empty().append(makeAlert("alert-danger","La contraseña no puede estar vacía", true));
		return false;
	} else if (pwd1.val() != pwd2.val()){
		if ( pwd1.val() != "" && pwd2.val() != ""){
			pwd1.parent().next().empty().append(makeAlert("alert-danger","Las contraseñas no coinciden", true));
		} else if ($(this).attr("id") == undefined){
			pwd1.parent().next().empty().append(makeAlert("alert-danger","Las contraseñas no coinciden", true));
		}
		return false;
	}
	return true;
}
function validarEmail() {
	var email = $('#email_signup');
	if (email.val() != "") email.parent().next().empty();

	if ($(this).attr("id") == undefined && email.val() == ""){
		email.parent().next().empty().append(makeAlert("alert-danger","El email no puede estar vacío", true));
		return false;
	}
	// expresión regular para validar la estructura del email
	var regular_expression = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/; 
	if (!regular_expression.test(email.val()) && email.val() != ""){
		email.parent().next().empty().append(makeAlert("alert-danger","El email no es correcto", true));
		return false;
	}
	return true;
}
function validarEdad() {
	var edad = $("#age_signup");
	edad.parent().next().empty();
	if (edad.val() == 0){
		edad.parent().next().append(makeAlert("alert-danger","Este campo es obligatorio", true));
		return false;
	}
	return true;
}
function validarBarrio(id) {
	var barrio = $("#"+id);
	barrio.parent().next().empty();
	if (barrio.val() == "---Barrio---"){
		barrio.parent().next().append(makeAlert("alert-danger","Debe elegir un barrio", true));
		return false;
	}
	return true;
}
function validarHobbies(id) {
	var hobbies = $("#"+id);
	var count = 0;
	hobbies.parent().next().empty();

	var checks = $('input[name='+id+']');
	$.each(checks, function(i, value) {
		if ($(value).is(':checked')) count+=1;
	});

	if (count == 0){
		hobbies.parent().next().append(makeAlert("alert-danger","Debe elegir al menos 1 hobby", true));
		return false;
	}
	return true;
}