<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" %>
<%@ page import="
	java.util.Date,
	java.text.SimpleDateFormat,
	javax.persistence.*,
	db.DB,
	models.*"
%>
<jsp:useBean id='db' class='db.DB' scope='application' />
<!DOCTYPE html>
<html lang="es">
<head>
	<% String titulo = "Evento";%>
	<%// carga la cabecera %>
	<%@ include file='partes/head.jsp' %>
	<% SimpleDateFormat sdf1 = new SimpleDateFormat("EEEEEEEEEE dd 'de' MMMMMMMMMM 'del' yyyy");
	SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm");
	String id = request.getParameter("id");
	Evento e = db.getEM().find(Evento.class, Integer.parseInt(id));
	String asistentes = "";
	for (Usuario u: e.getUsuarios()){
		asistentes += "<p><b>-</b> "+u.getIdUsuario()+"</p>";
	}%>
	<script type="text/javascript">
		function make() {
			<% if (e.getFecha().compareTo(new Date())>0) { %>
				makeNav(0, type_user);
			<% } else { %>
				makeNav(1, type_user);
			<% } %>
			makeEvento();
		}
		$(document).ready(make);
	</script>
</head>
<body>
	<%@ include file='partes/navbar.html' %>
	<section class="container mt-n3">
		<article class="bg-light shadow">
			<%// Titulo %>
			<div class="text-center text-uppercase font-weight-bold py-2"><h1><%= e.getTitulo() %></h1></div>
			<%// Contenido %>
			<div class="row contenido-evento">
				<%// Imagenes y hobbies %>
				<div class="col-md-8">
					<%// Carrousel %>
					<div id="imgs" class="carousel slide" data-ride="carousel">
						<% // Indicador  %>
						<ul class="carousel-indicators">
							<li data-target="#imgs" data-slide-to=0 class="active"></li>
						<% for(int i=1; i < e.getNumImg(); i++){ %>
							<li data-target="#imgs" data-slide-to=<%= i %>></li>
						<% } %>
						</ul>
						<% // Imagenes  %>
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img class="d-block w-100" src=<%= e.getRutaImg()+"/"+0+".jpg" %> alt="First slide">
							</div>
						<% for(int i=1; i < e.getNumImg(); i++){ %>
							<div class="carousel-item">
								<img class="d-block w-100" src="<%= e.getRutaImg()+"/"+i+".jpg" %>" alt="First slide">
							</div>
						<% } %>
						</div>
						<% // Botones IZQ y DER  %>
						<a class="carousel-control-prev" href="#imgs" data-slide="prev">
							<span class="carousel-control-prev-icon"></span>
						</a>
						<a class="carousel-control-next" href="#imgs" data-slide="next">
							<span class="carousel-control-next-icon"></span>
						</a>
					</div>
					<%// Hobbies %>
					<div>
					<% 	for (Hobby hobby: e.getHobbies()){ %>
							<small class="text-info ml-2">#<%= hobby.getDescripcion()%> </small>
					<% 	} %>
					</div>
				</div>
				<%// Informacion %>
				<div class="info-evento col-md-4">
					<p><b>Cuando: </b><%= sdf1.format(e.getFecha()) %></p>
					<p><b>Hora: </b><%= sdf2.format(e.getFecha()) %></p>
					<p><b>Donde: </b><%= e.getBarrio() %></p>
					<p><b>Direccion: </b><%= e.getDireccion() %></p>
					<p><b>Creador: </b><%= e.getAdmin().getUsuario().getIdUsuario() %></p>
					<% if (session.getAttribute("name") == null) { %>
					<p id="asistentes"><b>Asistentes:</b><%= e.getUsuarios().size() %></p>
					<% } else { %>
					<p id="asistentes" data-toggle="popover" data-placement="left"  data-trigger="hover" title="Lista de asistentes" data-content="<%= asistentes %>">
						<b>Asistentes: </b><%= e.getUsuarios().size() %>
					</p>
					<% }
					if (e.getFecha().compareTo(new Date())>0) {
						if (session.getAttribute("name") != null) {
							Usuario u = db.getEM().find(Usuario.class, session.getAttribute("name"));
							String textBtnAsistir = "";
							if (!e.getUsuarios().contains(u) || u == null)
								textBtnAsistir = "Asistir";
							else
								textBtnAsistir = "No asistir";%>
							<button id="asistir" value=<%= e.getIdEvento() %> type="button" class="btn btn-primary mt-3"><%= textBtnAsistir %></button>
							<%
							if(esAdmin != null) {
								if(esAdmin.booleanValue()) { %>
									<button type="button" class="btn btn-success mt-3">Modificar</button>
								<% } 
							} 
						}
					} %>
				</div>
			</div>
			<%// Descripcion %>
			<div class="text-justify p-3">
				<p><%= e.getDescripcion() %></p>
			</div>
		</article>
	</section>
	<%@ include file='partes/footer.html' %>
</body>
</html>