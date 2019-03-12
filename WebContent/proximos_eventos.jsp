<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" %>
<%@ page import="
	java.util.List,
	java.util.LinkedList,
	java.util.Date,java.text.SimpleDateFormat,
	java.util.Date,
	javax.persistence.*,
	db.DB,
	javax.servlet.ServletContext,
	models.*"
%>
<jsp:useBean id='db' class='db.DB' scope='application' />
<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="UTF-8">
	<title>Proximos eventos</title>
	<%// carga los frameworks comunes: jquery, bootstrap... %>
	<%@ include file='partes/head.html' %>
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
		function make() {
			makeNav(0, type_user);
			makeFilter();
			setTimeout("hiddenLoad();", 1000)
		}
		$(document).ready(make);
	</script>
</head>
<body>
	<div id="main" class="d-none">
		<%@ include file='partes/navbar.html' %>
		<%//  %>
		<div class="row m-0 w-100 mt-n4">
			<%// filtros %>
			<%@ include file='partes/filter.jsp' %>
			<%// historial %>
			<aside class="container col-md-2 col-12 order-md-3 p-0 w-100">
				<button class="btn btn-secondary no-rounded btn-block d-md-none" data-toggle="collapse" id="collapse-historial">Historial</button>
				<div id="historial" class="d-none d-md-block pl-3 py-4">
					<h5>Historial</h5>
					<ul class="nav flex-column">
						<li class="nav-item">
							<button class="nav-link btn btn-link dropdown-toggle" data-toggle="collapse" data-target="#demo">2019</button>
							<div id="demo" class="collapse">
								<ul class="nav flex-column ml-2">
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Marzo</button>
									</li>
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Febrero</button>
									</li>
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Enero</button>
									</li>
								</ul>
							</div>
						</li>
						<li class="nav-item">
							<button class="nav-link btn btn-link dropdown-toggle" data-toggle="collapse" data-target="#demo2">2018</button>
							<div id="demo2" class="collapse">
								<ul class="nav flex-column ml-2">
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Diciembre</button>
									</li>
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Noviembre</button>
									</li>
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Octubre</button>
									</li>
									<li class="nav-item">
										<button class="nav-link btn btn-link py-0">Septiembre</button>
									</li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
			</aside>
			<%// sección con los eventos %>
			<section id="eventos" class="container col-xl-8 col-md-7 col-12 px-3 mt-2"> 
			<%	SimpleDateFormat sdf = new SimpleDateFormat("EEEEEEEEEE dd 'de' MMMMMMMMMM 'del' yyyy 'a las' HH:mm");
			
				int count;
				String sql = "";
				List<Evento> eventos = new LinkedList<>();
				
				String barrio = request.getParameter("distric");
				String hobbies[] = request.getParameterValues("hobbies");
				
				System.out.println("barrio: "+barrio);
				System.out.println("hobbies: "+hobbies);
				
				if (barrio != null && !"---Barrio---".equals(barrio)) {
					sql += (" e.barrio = '"+barrio+"' AND");
				}
				TypedQuery<Evento> query2 = db.getEM().createQuery("SELECT e FROM Evento e WHERE"+sql+" e.fecha > ?1 ORDER BY e.fecha", Evento.class);
				query2.setParameter(1, new Date());
				
				if (hobbies != null) {
					for (Evento e: query2.getResultList()) {
						count = 0;
						for (Hobby h: e.getHobbies()){
							for (String hobby: hobbies) {
								if (h.getIdHobbie() == Integer.parseInt(hobby))
									count++;
							}
						}
						if (count > 0)
							eventos.add(e);
					}
					
				} else {
					eventos = query2.getResultList();
				}
				
				for (Evento e : eventos) { %>
					<article class="evento media border bg-light p-3 my-2">
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
			<%	} %>
			</section>
		</div>
		<%@ include file='partes/footer.html' %>
	</div>
	<%// pantalla de carga mientras carga el contenido  %>
	<div id="load">
		<div class="container container-load d-flex justify-content-center align-items-center">
			<div class="load spinner-grow text-warning"></div>
		</div>
	</div>
</body>
</html>