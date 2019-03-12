<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" %>
<%@ page import="
	java.util.Date,java.text.SimpleDateFormat,
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
	<script type="text/javascript">
		function make() {
			makeNav(0, type_user);
		}
		$(document).ready(make);
	</script>
</head>
<body>
	<section class="container">
		<% SimpleDateFormat sdf = new SimpleDateFormat("EEEEEEEEEE dd 'de' MMMMMMMMMM 'del' yyyy 'a las' HH:mm");
		String id = request.getParameter("id");
		Evento e = db.getEM().find(Evento.class, Integer.parseInt(id)); %>
		<article class="evento media border bg-light p-3 my-2" id="<%= e.getIdEvento() %>">
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
				<p><small><i><%= sdf.format(e.getFecha()) %></i></small></p>
				<p class="mb-2"><small><b><%= e.getBarrio() %></b></small></p>
				<p><%= e.getDescripcion() %></p>
			</div>
		</article>
	</section>
</body>
</html>