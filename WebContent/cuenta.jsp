<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" %>
<%@ page import="
	java.util.List,
	java.util.LinkedList,
	java.util.Date,java.text.SimpleDateFormat,
	java.util.Date,
	javax.persistence.*,
	db.DB,
	models.*"
%>
<jsp:useBean id='db' class='db.DB' scope='application' />
<!DOCTYPE html>
<html lang="es">
<head>
	<% String titulo = "Cuenta";%>
	<%// carga la cabecera %>
	<%@ include file='partes/head.jsp' %>
	<script type="text/javascript">
		function make() {
			makeNav(1, type_user);
		}
		$(document).ready(make);
	</script>
</head>
<body>
	<%@ include file='partes/navbar.html' %>
	<section>
		<div id="main"></div>
	</section>
	<%@ include file='partes/footer.html' %>
</body>
</html>