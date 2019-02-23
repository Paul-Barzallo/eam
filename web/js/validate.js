function addValidatesAccess() {
	$('#signup input[type="password"]').blur(validarPasswords);
	$('#email_signup').blur(validarEmail);
	$('#age_signup').blur(validarEdad);
}

function validarPasswords() {
	var pwd1 = $(this);
	var pwd2;
	if (pwd1.attr("id").endsWith("1")) pwd2 = $("#pwd_signup_2");
	else pwd2 = $("#pwd_signup_1");

	pwd1.parent().next().empty();
	pwd2.parent().next().empty();

	if (pwd1.val() != pwd2.val() && pwd1.val() != "" && pwd2.val() != ""){
		pwd1.parent().next().append(makeAlert("alert-danger","Las contraseñas no coinciden", false));
	}
}
function validarEmail() {
	var email = $(this);
	email.parent().next().empty();
	var regular_expression = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/; //expresión regular para validar la estructura del email
	if (!regular_expression.test(email.val()) && email.val() != ""){
		email.parent().next().append(makeAlert("alert-danger","El email no es correcto", false));
	}
}
function validarEdad() {
	var edad = $(this);
	email.parent().next().empty();
	if (edad.val() == 0){
		email.parent().next().append(makeAlert("alert-danger","El email no es correcto", false));
	}
}
function validarBarrio() {
	var barrio = $(this);
}
function validarHobbies() {
	var hobbies = $(this);
}
function submitSignup() {
	$("#form_signup").subit();
}