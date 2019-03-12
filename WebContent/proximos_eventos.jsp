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
	<% String titulo = "Poximos eventos";%>
	<%// carga la cabecera %>
	<%@ include file='partes/head.jsp' %>
	<script type="text/javascript">
		function make() {
			makeNav(0, type_user);
			makeFilter();
			makeClickArticles();
			setTimeout("hiddenLoad();", 1000)
		}
		$(document).ready(make);
	</script>
</head>
<body>
<% String compare = ">"; %>
<%@ include file='partes/eventos.jsp' %>
</body>
</html>