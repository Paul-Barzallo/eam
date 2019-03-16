<div id="main" class="d-none">
	<%@ include file='navbar.html' %>
	<%//  %>
	<div class="row m-0 w-100 mt-n4">
		<%// filtros %>
		<%@ include file='filter.jsp' %>
		<%// sección con los eventos %>
		<section id="eventos" class="container col-xl-10 col-md-9 col-12 px-3 pr-4 mt-2"> 
			<div class="row">
			<% SimpleDateFormat sdf = new SimpleDateFormat("dd 'de' MMMMMMMMMM 'del' yyyy 'a las' HH:mm");
			
			int count;
			String sql = "";
			List<Evento> eventos = new LinkedList<>();
			
			String barrio = request.getParameter("distric");
			String hobbies[] = request.getParameterValues("hobbies");		
			
			if (barrio != null && !"---Barrio---".equals(barrio)) {
				sql += (" e.barrio = '"+barrio+"' AND");
			}
			TypedQuery<Evento> query2 = db.getEM().createQuery("SELECT e FROM Evento e WHERE"+sql+" e.fecha "+compare+" ?1 ORDER BY e.fecha", Evento.class);
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
				<article class="col-xl-3 col-lg-4 col-sm-6 col-12 mb-4" id="<%= e.getIdEvento() %>">
					<div class="card h-100 shadow">
						<img class="card-img-top" src="<%= e.getRutaImg() %>/0.jpg" alt="Card image">
						<div class="card-body p-0 my-1">
							<div class="">
								<h4 class="card-title text-center"><%= e.getTitulo() %></h4>
							</div>
							<div class="bg-light pl-2">
							<% 	for (Hobby hobby: e.getHobbies()){ %>
								<small class="text-info mr-2">#<%= hobby.getDescripcion()%> </small>
							<% 	} %>
							</div>
							<div class="pl-2 mt-auto mb-2">
								<p><small><i><%= sdf.format(e.getFecha()) %></i></small></p>
								<p><small><b><%= e.getBarrio() %></b></small></p>
							</div>
						</div>
					</div>
				</article>
			<% } %>
			</div>
		</section>
	</div>
	<%@ include file='footer.html' %>
</div>
<%// pantalla de carga mientras carga el contenido  %>
<div id="load">
	<div class="container container-load d-flex justify-content-center align-items-center">
		<div class="load spinner-grow text-warning"></div>
	</div>
</div>