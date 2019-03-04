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
    var ruta = "login"+"?"+"user_login="+user+"&"+"pwd_login="+pwd;
    div.empty();

	$.post("login", {user_login: user, pwd_login: pwd})
	.done(function(respuesta, status){
		if (respuesta == 1) $(location).attr('href',"./");
    	else div.append(makeAlert("alert-danger","Usuario o contraseña incorrecta", true));
	})
	.fail(function(xhr, status, error){
		div.append(makeAlert("alert-danger","Error al conectar con el servidor", true));
	});
}