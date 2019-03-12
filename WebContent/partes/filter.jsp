<aside class="col-xl-2 col-md-3 col-12 p-0">
	<button class="btn btn-secondary no-rounded btn-block d-md-none mt-n4" data-toggle="collapse" id="collapse-filtros">Filtros</button>
	<form id="filtros" class="d-none d-md-block px-3 py-4" action="">
		<h5>Barrio:</h5>
		<select class="custom-select mb-3" name="distric" id="distric"></select>
		<h5>Hobbies:</h5>
		<div class="m-0 pl-2 pb-2" id="hobbies">
		<% 	TypedQuery<Hobby> query = db.getEM().createQuery("SELECT h from Hobby h", Hobby.class);
			for (Hobby h : query.getResultList()) { %>
				<div class="custom-control custom-checkbox">
					<input type="checkbox" class="custom-control-input" id="hobbies_<%= h.getIdHobbie() %>" name="hobbies" value="<%= h.getIdHobbie() %>">
					<label class="custom-control-label" for="hobbies_<%= h.getIdHobbie() %>"><%= h.getDescripcion() %></label>
				</div>
		<% } %>
		</div>
		<button class="btn btn-primary px-5" type="submit">Buscar</button>
	</form>
</aside>