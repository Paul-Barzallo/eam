<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
	<% String titulo = "Estadisticas";%>
	<%// carga la cabecera %>
	<%@ include file='partes/head.jsp' %>
	<script type="text/javascript">
		function make() {
			makeNav(3, type_user);
		}
		$(document).ready(make);
	</script>
</head>
<body>
	<%@ include file='partes/navbar.html' %>
	<%@ include file='partes/footer.html' %>
</body>
</html>