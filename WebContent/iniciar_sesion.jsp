<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="
	java.util.List,
	java.util.LinkedList,
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
			makeNav(-1, type_user);
			makeAccess();
			addValidatesAccess();
		}
		$(document).ready(make);
	</script>
</head>
<body>
	<%@ include file='partes/navbar.html' %>
	<section class="container">
		<article class="container mt-5 d-flex justify-content-center">
			<div class="col-lg-6 col-md-8 col-10">
				<%// Pestañas %>
				<ul class="nav nav-tabs">
					<li class="nav-item">
						<a class="nav-link active show" data-toggle="tab" href="#login">Iniciar sesión</a>
					</li>
					<li class="nav-item">
						<a class="nav-link show" data-toggle="tab" href="#signup">Registrarse</a>
					</li>
				</ul>
				<%// Contenido de las pestañas %>
				<div class="tab-content">
					<%/* Login
					Names:
						user_login
						pwd_login
					*/%>
					<div class="tab-pane container active show" id="login">
						<form id="form_login">
							<%// User %>
							<div class="input-group mb-3 mt-4">
								<div class="input-group-prepend">
									<i class="input-group-text material-icons">person</i>
								</div>
								<input class="form-control" type="text" placeholder="Usuario" id="user_login" name="user" autofocus>
							</div>
							<%// Password %>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<i class="input-group-text material-icons">vpn_key</i>
								</div>
								<input class="form-control" type="password" placeholder="Contraseña" id="pwd_login" name="pwd">
							</div>
							<%// Remember me %>
							<div class="custom-control custom-switch mb-3">
								<input type="checkbox" class="custom-control-input" id="switch_login" name="switch_login">
								<label class="custom-control-label" for="switch_login">Recordarme</label>
							</div>
							<%// Submit %>
							<div class="d-flex justify-content-center">
								<button class="btn btn-primary pr-5 pl-5" type="button" id="btn_login">Iniciar sesión</button>
							</div>
							<%// Error en el login %>
							<div id="error_login" class="mb-3"></div>
						</form>
					</div>
					<%/* Signup 
					names:
						user_signup
						pwd_signup_1
						pwd_signup_2
						email_signup
						age_signup
						distric_signup
						hobbies_sigunp
					*/%>
					<div class="tab-pane container fade" id="signup">
						<form id="form_signup">
							<%// User %>
							<div class="input-group mb-3 mt-4">
								<div class="input-group-prepend">
									<i class="input-group-text material-icons">person</i>
								</div>
								<input class="form-control" type="text" placeholder="Usuario" id="user_signup" name="user">
							</div>
							<%// Alert Usuario %>
							<div class="mb-3"></div>
							<%// Password %>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<i class="input-group-text material-icons">vpn_key</i>
								</div>
								<input class="form-control" type="password" placeholder="Contraseña" id ="pwd_signup_1" name="pwd">
							</div>
							<%// Alert Contraseña incorrecta %>
							<div class="mb-3"></div>
							<%// Repeat password %>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<i class="input-group-text material-icons">vpn_key</i>
								</div>
								<input class="form-control" type="password" placeholder="Repitir la contraseña" id="pwd_signup_2" name="pwd_signup_2">
							</div>
							<%// Alert Contraseña incorrecta %>
							<div class="mb-3"></div>
							<%// Email %>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<i class="input-group-text material-icons">email</i>
								</div>
								<input class="form-control" type="text" placeholder="Email" id="email_signup" name="email_signup">
							</div>
							<%// Alert Email %>
							<div class="mb-3"></div>
							<%// Age %>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<i class="input-group-text material-icons">cake</i>
								</div>
								<select class="custom-select" name="age_signup" id="age_signup"></select>
							</div>
							<%// Alert Age %>
							<div class="mb-3"></div>
							<%// Distric %>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<i class="input-group-text material-icons">location_city</i>
								</div>
								<select class="custom-select" name="distric_signup" id="distric_signup"></select>
							</div>
							<%// Alert Distric %>
							<div class="mb-3"></div>
							<%// Hobbies %>
							<fieldset class="border p-2 mb-4">
								<legend  class="w-auto">Hobbies</legend>
								<div class="row m-0  px-3 pb-2" id="hobbies_signup">
								<% TypedQuery<Hobby> query = db.getEM().createQuery("SELECT h from Hobby h", Hobby.class);
									for (Hobby h : query.getResultList()) { %>
										<div class="custom-control custom-checkbox col-md-6">
											<input type="checkbox" class="custom-control-input" id="hobbies_signup_<%= h.getIdHobbie() %>" name="hobbies_signup" value="<%= h.getIdHobbie() %>">
											<label class="custom-control-label" for="hobbies_signup_<%= h.getIdHobbie() %>"><%= h.getDescripcion() %></label>
										</div>
								<% } %>
								</div>
							</fieldset>
							<%// Alert Hobbies %>
							<div class="mb-3"></div>
							<%// Button %>
							<div class="d-flex justify-content-center">
								<button class="btn btn-primary pr-5 pl-5" id="btn_signup" type="button">Registrarse</button>
							</div>
							<%// Error en el Sigup %>
							<div id="error_signup" class="mb-3"></div>
						</form>
					</div>
				</div>
			</div>
		</article>
	</section>
	<%@ include file='partes/footer.html' %>
</body>
</html>