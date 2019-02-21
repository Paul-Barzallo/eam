$(document).ready(makeAccess);

function makeAccess(){
	var ages = 		["---Rango de edad---","< 18","18 - 25","26 - 30","31 - 35","36 - 40", "> 40"];
	var districs = 	["---Barrio---","Arganzuela","Barajas","Canillejas","Carabanchel","Centro","Chamartin","Chamberi","Ciudad Lineal","El pardo-Fuencarral","Hortaleza","Latina","Moncloa","Moratalaz","Puente de Vallecas","Retiro","Salamanca","Tetuan","Usera","Vicalvaro","Villa de Vallecas","Villaverde"];
	var hobbies = 	["futbol", "baloncesto", "senderismo", "juegos de mesa", "cine", "cartas", "museos", "gastronomía", "manualidades"];
	var name_hobbies = "hobbies_signup";
	var select_age = $("#age_signup");
	var select_distric = $("#distric_signup");
	var div_checks = $("#hobbies_signup");

	$('#signup input[type="password"]').blur(validatePasswords);
	$('#email_signup').blur(validateEmail);

	makeSelect(select_age, ages, false);
	makeSelect(select_distric, districs, true);
	makeChecks(div_checks, hobbies, name_hobbies, "col-sm-6");
}
function makeSelect(select, list, value_equals_text) {
	select = $(select);
	$.each(list, function(i, elem){
		let option = $("<option>");
		let value;
		if (value_equals_text) value = elem;
		else value = i;
		option.attr("value",value).text(elem);
		select.append(option)
	});
}
function makeChecks(div, list, name_check, class_div_check){
	var div = $(div);
	$.each(list, function(i, elem){
		let div_check = $('<div class="custom-control custom-checkbox">');
		let check = $('<input type="checkbox" class="custom-control-input">');
		let label = $('<label class="custom-control-label">');
		let id_check = name_check+"_"+i;
		check.attr({id: id_check,
					name: name_check,
					value: elem});
		label.attr("for", id_check).text(elem);
		div_check.addClass(class_div_check).append([check, label]);
		div.append(div_check);
	});
}
function makeAlert(color, text, add_btn) {
	let alert = $('<div class="alert alert-dismissible fade show w-auto mt-3 mb-0">');
	alert.addClass(color).append(text);
	if (add_btn) alert.prepend('<button type="button" class="close" data-dismiss="alert">&times;</button>')
	return alert;
}
function validatePasswords() {
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
function validateEmail() {
	var email = $(this);
	email.parent().next().empty();
	var regular_expression = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	if (!regular_expression.test(email.val()) && email.val() != ""){
		email.parent().next().append(makeAlert("alert-danger","El email no es correcto", false));
	}
}
function validarHobbies() {
	// body...
}
function sumbitSignup() {
	$("#form_signup").subit();
}