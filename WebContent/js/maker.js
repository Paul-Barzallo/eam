var barrios = [
	"---Barrio---",
	"Arganzuela","Barajas",
	"Canillejas",
	"Carabanchel",
	"Centro",
	"Chamartin",
	"Chamberi",
	"Ciudad Lineal",
	"El pardo-Fuencarral",
	"Hortaleza",
	"Latina",
	"Moncloa",
	"Moratalaz",
	"Puente de Vallecas",
	"Retiro",
	"Salamanca",
	"Tetuan",
	"Usera",
	"Vicalvaro",
	"Villa de Vallecas",
	"Villaverde"
];

/*
 *Crea el Nav diferenciando los enlaces segun el tipo de usuario
 *	active: indica la posisión del enlace activo,-3 para HOME, -2 para cuenta y -1 para iniciar sesión y cerrar sesión
 *	type_user: identifica si es un usuario (0), un admin (1) o no está logueado (-1)
 */
function makeNav(active, type_user){
	var icon_login = "flight_land";
	var icon_logout = "flight_takeoff";
	var ul1 = $("#nav_ul_enlaces");
	var ul2 = $("#nav_ul_enlace_log");
	var enlaces1 = ["proximos_eventos", "eventos_pasados"];
	var enlaces2 = ["proximos_eventos", "eventos_pasados", "crear_evento", "estadisticas"];
	var enlaces;

	//se carga el boton de cuenta o login y se eligen los enlaces
	if (type_user == -1){
		enlaces = enlaces1;
		let li = makeBtnLogin(active, icon_login);
		ul2.append(li);
	} else if (type_user == 0){
		enlaces = enlaces1;
		let li = makeBtnAcount(active, icon_logout);
		ul2.append(li);
	} else if (type_user == 1){
		enlaces = enlaces2;
		let li = makeBtnAcount(active, icon_logout);
		ul2.append(li);
	}
	//se crea el nav
	$.each(enlaces, function(i, value){
		let li = $('<li class="nav-item">');
		let a = $('<a class="nav-link">');
		a.attr("href", value+".jsp").text(value.replace("_", " "));
		if (active == i) a.addClass("active");
		li.append(a);
		ul1.append(li);
	});
}

//Crea el enlace al login
function makeBtnLogin(active, icon) {
	var li = $('<li class="nav-item">');
	var a = $('<a class="nav-link">');
	var i = $('<i class="material-icons align-middle pb-2">');
	i.text(icon);
	a.attr("href", "iniciar_sesion.jsp").append("iniciar sesión", i);
	if (active == -1) a.addClass("active");
	li.append(a);
	return li;
}

//Crea el boton de cuenta
function makeBtnAcount(active, icon){
	var li = $('<li class="nav-item dropdown">');
	var a = $('<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Cuenta</a>');
	var div = $('<div class="dropdown-menu dropdown-menu-right">');
	var a_conf = $('<a class="dropdown-item">Configurar</a>');
	var a_logout = $('<a class="dropdown-item">Cerrar sesión</a>');
	var i_logout = $('<i class="material-icons align-middle pb-2">');
	i_logout.text(icon);
	a_logout.append(i_logout).attr("href", "logout");
	a_conf.attr("href", "cuenta.jsp");
	div.append(a_conf, a_logout);
	if (active == -2) {
		a.addClass("active");
		a_conf.addClass("active");
	}
	li.append(a, div);
	return li;
}

//Crea las partes del login y del signup
function makeAccess(){
	var ages = ["---Rango de edad---","< 18","18 - 25","26 - 30","31 - 35","36 - 40", "> 40"];
	
	var select_age = $("#age_signup");
	var select_distric = $("#distric_signup");

	makeSelect(select_age, ages, false);
	makeSelect(select_distric, barrios, true);
}

/*
 * Rellena un carrousel de imagenes
 *  .carousel-indicators debe tener id="carrousel-indicador"
 *  .carousel-inner debe tener id="carrousel-imgs"
 *  dir_img -> la ruta relativa de la carpeta donde están las imagenes a cargar
 *  num_img -> numero de imagenes en la carpeta
 */
function makeCarrousel(dir_img, num_img) {
	var ul = $('#carrousel-indicador');
	var div = $('#carrousel-imgs');

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

/*
 *Rellena un select con contenido
 *	select: etiqueta select a rellenar
 *	list: list con los valores a añadir
 * 	value_equals_text: 'true' para que el value sea el mismo que el texto
 *					   'false' los valores serán numeros empezando con 0
 */
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

/*
 *Crea un alert para dar información
 *	color: el color de alert
 *  text: texto que contendrá el alert
 *	add_boton : true para añadir un boton que deja eliminar el alert
 */
function makeAlert(color, text, add_btn) {
	let alert = $('<div class="alert alert-dismissible fade show w-auto mt-3 mb-0">');
	alert.addClass(color).append(text);
	if (add_btn) alert.prepend('<button type="button" class="close" data-dismiss="alert">&times;</button>')
	return alert;
}

//Rellena el select y pone los eventos en los botones de filtro e historial
function makeFilter(){
	var districs = 	["---Barrio---","Arganzuela","Barajas","Canillejas","Carabanchel","Centro","Chamartin","Chamberi","Ciudad Lineal","El pardo-Fuencarral","Hortaleza","Latina","Moncloa","Moratalaz","Puente de Vallecas","Retiro","Salamanca","Tetuan","Usera","Vicalvaro","Villa de Vallecas","Villaverde"];
	var select_distric = $("#distric");
	
	var historial = $("#collapse-historial")
	if (historial != undefined )
		historial.click(collapseHistorial)

	$("#collapse-filtros").click(collapseFiltro)
	
	makeSelect(select_distric, districs, true);
}

//Oculta la pantalla de carga y muestra el contenido en las pantallas de eventos
function hiddenLoad(){
	$("#load").addClass("d-none");
	$("#main").removeClass("d-none");
}

//Muestra y oculta los filtros
function collapseFiltro(){
	filtros = $("#filtros");
	if (filtros.hasClass("d-none"))
		filtros.removeClass("d-none d-md-block");
	else 
		filtros.addClass("d-none d-md-block");
}

//Muestra y oculta el historial
function collapseHistorial(){
	historial = $("#historial");
	if (historial.hasClass("d-none"))
		historial.removeClass("d-none d-md-block");
	else 
		historial.addClass("d-none d-md-block");
}

// Añade el evento click a los eventos para redireccionar a ese evento
function makeClickArticles(){
	var articles = $("article").css( 'cursor', 'pointer' );
	$.each(articles, function (i, value){
		let article = $(value);
		article.click(clickArticle);
	});
}

// Redirecciona a un evento
function clickArticle(){
	$(location).attr('href',"evento.jsp?id="+$(this).attr("id"));
}

// Añade el popover para ver los asistentes y el evento click para asistir
function makeEvento(){
	$("#asistentes").popover({html: true});
	$("#asistir").click(asistir);
	var barrio = $("#barrio");
	makeSelect(barrio, barrios, true);
}

// redirecciona al servlet que registra a un usuario en un evento
function asistir(){
	$(location).attr('href',"register?evento="+$(this).val());
}
