<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="
	javax.persistence.*,
	db.DB,
	models.*"
%>
<jsp:useBean id='db' class='db.DB' scope='application' />
<!DOCTYPE html>
<html lang="es">
<head>
	<% String titulo = "Iniciar sesión";%>
	<%// carga la cabecera %>
	<%@ include file='partes/head.jsp' %>
	<script src="js/validate.js"></script>
	<script type="text/javascript">
		function make() {
			makeNav(2, type_user);
			makeEvento();
			addValidatesCrearEvento();
		}
		$(document).ready(make);
	</script>
</head>
<body>
	<%@ include file='partes/navbar.html' %>
	<section class="container">
		<article class="container">
			<form id="form_evento" action="createEvent" method="post" enctype="multipart/form-data">
				<%// Titulo %>
				<div class="input-group my-2">
					<div class="input-group-prepend">
						<i class="input-group-text material-icons">title</i>
					</div>
					<input class="form-control" type="text" placeholder="Titulo" id="titulo" name="titulo" maxlength="60" required autofocus>
				</div>
				<%// Alert Titulo %>
				<div class="mb-3"></div>
				<%// Fecha %>
				<div class="input-group my-2">
					<div class="input-group-prepend">
						<i class="input-group-text material-icons">today</i>
					</div>
					<input class="form-control" type="datetime-local" id="fecha" name="fecha" required>
				</div>
				<%// Alert Fecha %>
				<div class="mb-3"></div>
				<%// Barrio %>
				<div class="input-group my-2">
					<div class="input-group-prepend">
						<i class="input-group-text material-icons">location_city</i>
					</div>
					<select class="custom-select" name="barrio" id="barrio"></select>
				</div>
				<%// Alert Barrio %>
				<div class="mb-3"></div>
				<%// Direccion %>
		 		<div class="input-group my-2">
					<div class="input-group-prepend">
						<i class="input-group-text material-icons">location_on</i>
					</div>
					<input class="form-control" type="text" placeholder="Direccion" id="direccion" name="direccion" maxlength="60" required>
				</div>
				<%// Alert Direccion %>
				<div class="mb-3"></div>
				<%// Descripcion %>
				<div class="form-group my-2">
					<label for="descripcion"><h4>Descripcion:</h4></label>
					<textarea class="form-control" id="descripcion" name="descripcion" placeholder="Informacion sobre el evento"  maxlength="1000" rows="5" required></textarea>
				</div>
				<%// Alert Descripcion %>
				<div class="mb-3"></div>
				<%// Hobbies %>
				<fieldset class="border p-2 mb-4">
					<legend  class="w-auto"><h4>Hobbies</h4></legend>
					<div class="row m-0  px-3 pb-2" id="hobbies">
					<% TypedQuery<Hobby> query = db.getEM().createQuery("SELECT h from Hobby h", Hobby.class);
						for (Hobby h : query.getResultList()) { %>
							<div class="custom-control custom-checkbox col-lg-4 col-md-6">
								<input type="checkbox" class="custom-control-input" id="hobbies_<%= h.getIdHobbie() %>" name="hobbies" value="<%= h.getIdHobbie() %>">
								<label class="custom-control-label" for="hobbies_<%= h.getIdHobbie() %>"><%= h.getDescripcion() %></label>
							</div>
					<% } %>
					</div>
				</fieldset>
				<%// Alert Hobbies %>
				<div class="mb-3"></div>
				<%// Imagenes %>
				<div class="form-group my-2">
					<label for="imagenes"><h4>Imagenes:</h4></label>
					<div class="custom-file mb-3" id="imagenes">
						<input type="file" class="custom-file-input" id="img" name="img" accept="image/jpg" multiple>
						<label class="custom-file-label" for="img">Choose file</label>
					</div>
				</div>
				
				
				<%// Button %>
				<div class="d-flex justify-content-center">
					<button class="btn btn-primary pr-5 pl-5" id="btn_submit" type="button">Crear</button>
				</div>
			</form>
		</article>
	</section>
	<%@ include file='partes/footer.html' %>
</body>
</html>