  //active indica la posisión del enlace activo,-3 para HOME, -2 para cuenta y -1 para iniciar sesión y serrar sesión
function makeNav(active){
	var icon_login = "flight_land";
	var icon_logout = "flight_takeoff";
	var ul1 = $("#nav_ul_enlaces");
	var ul2 = $("#nav_ul_enlace_log");
	var type_user = "null"; //pedir este dato por ajax al servidor
	var enlaces;

	$.post("typeUser", {})
	.done(function(respuesta, status){
		type_user = respuesta;
		if (type_user == "null"){
			enlaces = ["proximos_eventos", "eventos_pasados"];
			let li = makeBtnLogin(active, icon_login);
			ul2.append(li);
		} else if (type_user == 0){
			enlaces = ["proximos_eventos", "eventos_pasados"];
			let li = makeBtnAcount(active, icon_logout);
			ul2.append(li);
		} else if (type_user == 1){
			enlaces = ["proximos_eventos", "eventos_pasados", "estadisticas"];
			let li = makeBtnAcount(active, icon_logout);
			ul2.append(li);
		}
		$.each(enlaces, function(i, value){
			let li = $('<li class="nav-item">');
			let a = $('<a class="nav-link">');
			a.attr("href", value+".html").text(value.replace("_", " "));
			if (active == i) a.addClass("active");
			li.append(a);
			ul1.append(li);
		});
	})
	.fail(function(xhr, status, error){
		alert("Error al conectar con el servidor");
	});
}
function makeHome() {
	makeCarrousel("img/home/", 3);
	$.get("remember");
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
function makeBtnLogin(active, icon) {
	var li = $('<li class="nav-item">');
	var a = $('<a class="nav-link">');
	var i = $('<i class="material-icons align-middle pb-2">');
	i.text(icon);
	a.attr("href", "iniciar_sesion.html").append("iniciar sesión", i);
	if (active == -1) a.addClass("active");
	li.append(a);
	return li;
}
function makeBtnAcount(active, icon){
	var li = $('<li class="nav-item dropdown">');
	var a = $('<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Cuenta</a>');
	var div = $('<div class="dropdown-menu dropdown-menu-right">');
	var a_dropdown = $('<a class="dropdown-item">Configurar</a>');
	var btn_dropdown = $('<button class="btn btn-link dropdown-item" type="button" id="btn_logout">');
	var i_btn = $('<i class="material-icons align-middle pb-2">');
	i_btn.text(icon);
	btn_dropdown.click(login).append("cerrar sesión", i_btn);
	a_dropdown.attr("href", "cuenta.html");
	div.append(a_dropdown, btn_dropdown);
	if (active == -1) {
		a.addClass("active");
		btn_dropdown.addClass("active");
	} else if (active == -2) {
		a.addClass("active");
		a_dropdown.addClass("active");
	}
	li.append(a, div);
	return li;
}
function login(){
	$.post("logout", {})
	.done(function(respuesta, status){
		$(location).attr('href',"./");
	})
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
function makeAlert(color, text, add_btn) {
	let alert = $('<div class="alert alert-dismissible fade show w-auto mt-3 mb-0">');
	alert.addClass(color).append(text);
	if (add_btn) alert.prepend('<button type="button" class="close" data-dismiss="alert">&times;</button>')
	return alert;
}

function makeCarrousel(dir_img, num_img) {
	var ul = $('#indicador');
	var div = $('#imagenes');
	var seguir = true;
	var count = 0;

	for (var i=0; i<num_img; i++){
		let li = $('<li data-target="#imgs">');
		let div_img = $('<div class="carousel-item">');
		let img = $('<img class="img-carrousel">');
		li.attr("data-slide-to", i);
		img.attr({src: dir_img+i+".jpg", alt:"imagen del evento "+(i+1)});
		if (i==0){
			li.addClass('active');
			div_img.addClass('active');
		}
		div_img.append(img);
		ul.append(li);
		div.append(div_img);
	}
}
