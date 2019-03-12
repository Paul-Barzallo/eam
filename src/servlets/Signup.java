package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DB;
import models.*;
import security.Encrypt;

@WebServlet("/signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DB db;
	
    public Signup() {
        super();
    }

    public void init(ServletConfig config) throws ServletException {
		super.init(config);
		ServletContext contextoAplicacion = this.getServletContext();
    	db = (DB)contextoAplicacion.getAttribute("db");
    	if (db == null) {
    		db = new DB();
    		contextoAplicacion.setAttribute("db", db);
    	}
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TypedQuery<Usuario> query;
		PrintWriter respuesta;
		HttpSession sesion;
		Usuario newUsuario;
		Usuario usuario;
		Hobby hobby;
		
		String idUsuario = request.getParameter("user");
		String password = request.getParameter("pwd");
		String email = request.getParameter("email");
		Integer edad = Integer.parseInt(request.getParameter("age"));
		String barrio = request.getParameter("distric");
		String hobbies[] =  request.getParameterValues("hobbies[]");
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		respuesta = response.getWriter();
		
		query = db.getEM().createQuery("SELECT u FROM Usuario u WHERE u.idUsuario = ?1 OR u.email = ?2", Usuario.class);
		query.setParameter(1, idUsuario);
		query.setParameter(2, email);
		try {
			usuario = query.getSingleResult();
		} catch (Exception e) {
			usuario = null;
		}	
		if (usuario == null) {
			newUsuario = new Usuario(idUsuario, Encrypt.MD5(password), email, edad, barrio);
			EntityTransaction et = db.getEM().getTransaction();
			et.begin();
			db.getEM().persist(newUsuario);
			for (String hId: hobbies) {
				hobby = db.getEM().find(Hobby.class, Integer.parseInt(hId));
				hobby.addUsuario(newUsuario);
				db.getEM().merge(hobby);
			}
			et.commit();
			
			sesion = request.getSession(true);
			sesion.setAttribute("name", newUsuario.getIdUsuario());
			sesion.setAttribute("esAdmin", newUsuario.getEsAdmin());
			
			respuesta.append("0");
		} else if (usuario.getIdUsuario().equals(idUsuario)) {
			respuesta.append("1");
		} else {
			respuesta.append("2");
		}
	}
}
