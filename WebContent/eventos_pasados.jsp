<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" %>
<%@ page import="
	java.util.List,
	java.util.LinkedList,
	java.util.Date,java.text.DateFormat,
	javax.persistence.*,
	db.DB,
	javax.servlet.ServletContext,
	models.*"
%>
<jsp:useBean id='db' class='db.DB' scope='application' />
<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="UTF-8">
	<title>Eventos pasados</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="css/estilo.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
	<script src="js/maker.js"></script>

	<script type="text/javascript">
		function make() {
			makeNav(1);
			makeFilter();
			setTimeout("hiddenLoad();", 1000)
		}
		$(document).ready(make);
	</script>
</head>
<body>
	<div id="main" class="d-none">
		<nav class="navbar navbar-expand-md bg-dark navbar-dark sticky-top">
			<a class="navbar-brand" href="./">
				<img src="img/logo.png" alt="logo" width="40">EAM
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#despegable">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="despegable">
				<ul class="navbar-nav" id="nav_ul_enlaces"></ul>
				<ul class="navbar-nav ml-auto" id="nav_ul_enlace_log"></ul>
			</div>
		</nav>

		<div class="row m-0 w-100 pt-3">
			<aside class="col-xl-2 col-md-3 col-12 p-0">
				<button class="btn btn-secondary no-rounded btn-block d-md-none mt-n4" data-toggle="collapse" id="collapse-filtros">Filtros</button>
				<form id="filtros" class="d-none d-md-block px-3 py-4">
					<h5>Barrio:</h5>
					<select class="custom-select mb-3" name="distric_signup" id="distric_signup"></select>

					<h5>Hobbies:</h5>
					<div class="m-0 pl-2 pb-2" id="hobbies_signup"></div>

					<button class="btn btn-primary px-5" id="btn_sign up" type="button">Buscar</button>
				</form>
			</aside>
			<aside class="container col-md-2 col-12 order-md-3 p-0 w-100">
				<button class="btn btn-secondary no-rounded btn-block d-md-none" data-toggle="collapse" id="collapse-historial">Historial</button>
				<div id="historial" class="d-none d-md-block pl-3 py-4">
					<h5>Historial</h5>
					<ul class="nav flex-column">
						<li class="nav-item">
							<button class="nav-link btn btn-link dropdown-toggle" data-toggle="collapse" data-target="#demo">2019</button>
							<div id="demo" class="collapse">
								<ul class="nav flex-column ml-2">
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Marzo</button>
									</li>
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Febrero</button>
									</li>
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Enero</button>
									</li>
								</ul>
							</div>
						</li>
						<li class="nav-item">
							<button class="nav-link btn btn-link dropdown-toggle" data-toggle="collapse" data-target="#demo2">2018</button>
							<div id="demo2" class="collapse">
								<ul class="nav flex-column ml-2">
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Diciembre</button>
									</li>
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Noviembre</button>
									</li>
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Octubre</button>
									</li>
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Septiembre</button>
									</li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
			</aside>
			<section id="eventos" class="container col-xl-8 col-md-7 col-12 px-3 mt-2"> 
			<%	DateFormat df = DateFormat.getDateInstance(DateFormat.FULL);
				TypedQuery<Evento> query = db.getEM().createQuery("SELECT e FROM Evento e", Evento.class);
				for (Evento e : query.getResultList()) { %>
					<article class="evento media border bg-light p-3 my-2">
						<div class="mr-3 mt-2">
							<img alt="Imagen de un evento" class="img-evento img-fluid img-thumbnail mb-2" src="<%= e.getRutaImg() %>/0.jpg">
							<div class="row hobbies-evento">
								<%	for (Hobby hobby: e.getHobbies()){ %>
										<div class="col-xl-6 col-12">
											<p class="text-info"><small>#<%= hobby.getDescripcion() %></small></p>
										</div>
								<%	} %>
							</div>
						</div>
						<div class="media-body text-justify">
							<h4><%= e.getTitulo() %></h4>
							<p><small><i><%= df.format(e.getFecha()) %></i></small></p>
							<p class="mb-2"><small><b><%= e.getBarrio() %></b></small></p>
							<p><%= e.getDescripcion() %></p>
						</div>
					</article>
			<%	} %>
			</section>
		</div>
		
		<footer class="container-fluid bg-dark text-center py-3">
			<p class="mb-2"><ins><b>Creado por:</b></ins></p>
			<div class="row d-flex justify-content-center">
				<p class="col-xl-2 col-lg-3 col-sm-4">Paul Barzallo</p>
				<p class="col-xl-2 col-lg-3 col-sm-4">Alvaro Villanova</p>
				<p class="col-xl-2 col-lg-3 col-sm-4">Borja Gomez-Rey</p>
			</div>
		</footer>
	</div>
	<div id="load">
		<div class="container container-load d-flex justify-content-center align-items-center">
			<div class="load spinner-grow text-warning"></div>
		</div>
	</div>
</body>
</html>