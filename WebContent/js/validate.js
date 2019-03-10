function addValidatesAccess() {
	$('#signup input[type="password"]').blur(validarPasswords);
	$('#email_signup').blur(validarEmail);
	$('#btn_signup').click(submitSignup);
	$('#btn_login').click(submitLogin);
}

function submitSignup() {
	count = 0;
	if (!validarUser()) count+=1;
	if (!validarPasswords()) count+=1;
	if (!validarEmail()) count+=1;
	if (!validarEdad()) count+=1;
	if (!validarBarrio()) count+=1;
	if (!validarHobbies()) count+=1;
	if (count == 0) $("#form_signup").submit();
}

function submitLogin(){
	var div = $("#error_login");
	var user = $("#user_login").val();
	var pwd = $("#pwd_login").val();
	var _switch_login = $('#switch_login').prop('checked');
    div.empty();

	$.post("validateLogin", {user_login: user, pwd_login: pwd, remember: _switch_login})
	.done(function(respuesta, status){
		if (respuesta == 1) $("#form_login").submit();
    	else div.append(makeAlert("alert-danger","Usuario o contraseña incorrecta", true));
	})
	.fail(function(xhr, status, error){
		div.append(makeAlert("alert-danger","Error al conectar con el servidor", true));
	});
}

function validarUser() {
	var user = $('#user_signup');
	if (user.val() == ""){
		user.parent().next().append(makeAlert("alert-danger","El usuario no puede estar vacío", true));
		return false;
	}
	return true;
}
function validarPasswords() {
	var pwd1 = $(this);
	var pwd2;

	if ($('#pwd_signup_1').val() != ""){
		$('#pwd_signup_1').parent().next().empty();
		$('#pwd_signup_2').parent().next().empty();
	}
	

	if (pwd1.attr("id") == undefined){
		pwd1 = $('#pwd_signup_1');
		pwd2 = $('#pwd_signup_2');
		if (pwd1.val() == "" && pwd2.val() == "") {
			pwd1.parent().next().append(makeAlert("alert-danger","La contraseña no puede estar vacía", true));
			return false;
		}
	}
	
	if (pwd1.attr("id").endsWith("1")) pwd2 = $("#pwd_signup_2");
	else pwd2 = $("#pwd_signup_1");

	if (pwd1.val() != pwd2.val() && pwd1.val() != "" && pwd2.val() != ""){
		pwd1.parent().next().append(makeAlert("alert-danger","Las contraseñas no coinciden", true));
		return false;
	}
	return true;
}
function validarEmail() {
	var email = $('#email_signup');
	if (email.val() != "") email.parent().next().empty();

	if ($(this).attr("id") == undefined && email.val() == ""){
		email.parent().next().append(makeAlert("alert-danger","El email no puede estar vacío", true));
		return false;
	}
	var regular_expression = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/; //expresión regular para validar la estructura del email
	if (!regular_expression.test(email.val()) && email.val() != ""){
		email.parent().next().append(makeAlert("alert-danger","El email no es correcto", true));
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
function validarBarrio() {
	var barrio = $("#distric_signup");
	barrio.parent().next().empty();
	if (barrio.val() == "---Barrio---"){
		barrio.parent().next().append(makeAlert("alert-danger","Este campo es obligatorio", true));
		return false;
	}
	return true;
}
function validarHobbies() {
	var hobbies = $("#hobbies_signup");
	var count = 0;
	hobbies.parent().next().empty();

	var checks = $('input[name="hobbies_signup"]');
	$.each(checks, function(i, value) {
		if ($(value).is(':checked')) count+=1;
	});

	if (count == 0){
		hobbies.parent().next().append(makeAlert("alert-danger","Este campo es obligatorio", true));
		return false;
	}
	return true;
}