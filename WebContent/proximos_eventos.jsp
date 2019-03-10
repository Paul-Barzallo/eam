<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="UTF-8">
	<title>Home</title>
	<%// carga los frameworks comunes: jquery, bootstrap... %>
	<%@ include file='partes/head.html' %>
	<script src="js/maker.js"></script>
	
	<script type="text/javascript">
		var type_user;
	<%	Integer type_user;
		System.out.println("entra en index");
		//request.getRequestDispatcher("/login").include(request, response);
		System.out.println("id: "+session.getId());
		try {
			type_user = (Integer)session.getAttribute("esAdmin");
			System.out.println("try: "+type_user);
		} catch(Exception e) {
			System.out.println("catch: "+e);
			type_user = null;
		}
		if (type_user == null) { %>
			type_user = -1;
	<%	} else if (type_user == 0) { %>
			type_user = 0;
	<%	} else if (type_user == 1) { %>
			type_user = 1;
	<%	} %>
		function make() {
			makeNav(-3, type_user);
		}
		$(document).ready(make);
	</script>
</head>
<body>
	<%@ include file='partes/navbar.html' %>
	<section class="container">
		
		<form action="./">
			<button type="submit">index</button>
		</form>
		
	</section>
	<%@ include file='partes/footer.html' %>
</body>
</html>