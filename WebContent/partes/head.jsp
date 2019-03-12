<meta charset="UTF-8">
<title><%= titulo %></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="css/estilo.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<script src="js/maker.js"></script>
<script type="text/javascript">
	var type_user;
<%	Boolean esAdmin;
	request.getRequestDispatcher("/login").include(request, response);
	try {
		esAdmin = (Boolean)session.getAttribute("esAdmin");
	} catch(Exception e) {
		esAdmin = null;
	}
	if (esAdmin == null) { %>
		type_user = -1;
<%	} else if (esAdmin.booleanValue()) { %>
	type_user = 1;
<%	} else { %>
	type_user = 0;
<%	} %>
</script>