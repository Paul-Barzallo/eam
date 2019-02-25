  //active indica la posisión del enlace activo,-2 para HOME y -1 para iniciar sesión y cuenta
function makeNav(active){
	var icon_login = "flight_land";
	var icon_logout = "";
	var ul1 = $("#nav_ul_enlaces");
	var ul2 = $("#nav_ul_enlace_log");
	var type_user = 0; //pedir este dato por ajax al servidor
	var enlaces;

	if (type_user == 0){
		enlaces = ["proximos_eventos", "eventos_pasados"];
		let li = $('<li class="nav-item">');
		let a = $('<a class="nav-link">');
		let i = $('<i class="material-icons align-middle pb-2">');
		i.text(icon_login);
		a.attr("href", "iniciar_sesion.html").append("iniciar sesión", i);
		if (active == -1) a.addClass("active");
		li.append(a);
		ul2.append(li)
	} else if (type_user == 1){
		enlaces = ["proximos_eventos", "eventos_pasados"];
	} else if (type_user == 2){
		enlaces = ["proximos_eventos", "eventos_pasados", "estadisticas"];
	}

	$.each(enlaces, function(i, value){
		let li = $('<li class="nav-item">');
		let a = $('<a class="nav-link">');
		a.attr("href", value+".html").text(value.replace("_", " "));
		if (active == i) a.addClass("active");
		li.append(a);
		ul1.append(li);
	});
}
function makeAccess(){
	var ages = 		["---Rango de edad---","< 18","18 - 25","26 - 30","31 - 35","36 - 40", "> 40"];
	var districs = 	["---Barrio---","Arganzuela","Barajas","Canillejas","Carabanchel","Centro","Chamartin","Chamberi","Ciudad Lineal","El pardo-Fuencarral","Hortaleza","Latina","Moncloa","Moratalaz","Puente de Vallecas","Retiro","Salamanca","Tetuan","Usera","Vicalvaro","Villa de Vallecas","Villaverde"];
	var hobbies = 	["futbol", "baloncesto", "senderismo", "juegos de mesa", "cine", "cartas", "museos", "gastronomía", "manualidades"];
	var name_hobbies = "hobbies_signup";
	var select_age = $("#age_signup");
	var select_distric = $("#distric_signup");
	var div_checks = $("#hobbies_signup");

	makeSelect(select_age, ages, false);
	makeSelect(select_distric, districs, true);
	makeChecks(div_checks, hobbies, name_hobbies, "col-md-6");
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

//add boton -> true para añadir un boton que deja eliminar el alert
function makeAlert(color, txt, add_btn) {
	let alert = $('<div class="alert alert-dismissible fade show w-auto mt-3 mb-0">');
	alert.addClass(color).append(txt);
	if (add_btn) alert.prepend('<button type="button" class="close" data-dismiss="alert">&times;</button>')
	return alert;
}


/*<li data-target="#imgs" data-slide-to="0" class="active"></li>

<div class="carousel-item active">
	<img src="la.jpg" alt="Los Angeles" width="1100" height="500">
</div>*/


function makeCarrousel(dir_img) {
	var ul = $('#indicador');
	var div = $('#imagenes');
	var seguir = true;
	var count = 0;

	while (seguir) {
		try {
			let li = $('<li data-target="#imgs">');
		} catch(err) {
			
		}
	}
}