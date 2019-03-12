<div id="main" class="d-none">
	<%@ include file='navbar.html' %>
	<%//  %>
	<div class="row m-0 w-100 mt-n4">
		<%// filtros %>
		<%@ include file='filter.jsp' %>
		<%// sección con los eventos %>
		<section id="eventos" class="container col-xl-10 col-md-9 col-12 px-3 pr-4 mt-2"> 
		<%	SimpleDateFormat sdf = new SimpleDateFormat("EEEEEEEEEE dd 'de' MMMMMMMMMM 'del' yyyy 'a las' HH:mm");
		
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
		<%	} %>
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