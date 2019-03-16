<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
	<% String titulo = "Home";%>
	<%// carga la cabecera %>
	<%@ include file='partes/head.jsp' %>
	<script type="text/javascript">
		function make() {
			makeNav(-3, type_user);
			makeCarrousel("img/home/", 3);
		}
		$(document).ready(make);
	</script>
</head>
<body>
	<%@ include file='partes/navbar.html' %>
	<section class="container">
		<%// Carrousel %>
		<article class="container mx-0 d-flex justify-content-center">
			<div id="imgs" class="carousel slide col-lg-8 col-md-10 col-12" data-ride="carousel">
				<% // Indicador  %>
				<ul class="carousel-indicators" id="carrousel-indicador"></ul>
				<% // Imagenes  %>
				<div class="carousel-inner" id="carrousel-imgs"></div>
				<% // Botones IZQ y DER  %>
				<a class="carousel-control-prev" href="#imgs" data-slide="prev">
					<span class="carousel-control-prev-icon"></span>
				</a>
				<a class="carousel-control-next" href="#imgs" data-slide="next">
					<span class="carousel-control-next-icon"></span>
				</a>
			</div>
		</article>
		
		<% // Información  %>
		<article class="container mt-3 mx-0 text-justify d-flex justify-content-center">
			<div class="col-lg-10 col-12">
				<p class="mb-2">En esta pagina se publican eventos en diferentes barrios de madrid indicando el tipo de hobbies que están implicado para poder apuntarte a uno de los eventos debes estar registrado y haber iniciado sesión, si no estás registrado a que esperas, ¡unete a nuestra comunidad!</p>
				<% if (esAdmin == null) { %>
					<div class="container">
						<p><b>Si creas una cuenta tendras muchas ventasjas:</b></p>
						<p> -Te mostraremos eventos segun tus intereses</p>
						<p> -Podras ver quienes se han apuntado a los eventos</p>
						<p> -Tendras un registro de los eventos</p>
						<p> -Puedes comentar los eventos a los que asististe</p>
					</div>
				<% } %>
			</div>
		</article>
		
		
	</section>
	<%@ include file='partes/footer.html' %>
</body>
</html>