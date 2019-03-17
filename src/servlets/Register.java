package servlets;

import java.io.IOException;

import javax.persistence.EntityTransaction;
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

@WebServlet("/register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DB db; 
	
    public Register() {
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
		HttpSession sesion = request.getSession(true);
		String idUsuario = (String)sesion.getAttribute("name");
		if (idUsuario == null)
			response.sendRedirect("iniciar_sesion.jsp");
		else {
			int idEvento = Integer.parseInt(request.getParameter("evento"));
			Evento e = db.getEM().find(Evento.class, idEvento);
			Usuario u = db.getEM().find(Usuario.class, idUsuario);
			EntityTransaction et = db.getEM().getTransaction();
			et.begin();
			if (e.getUsuarios().contains(u)) {
				e.removeUsuario(u);
				u.removEvento(e);
			} else {
				e.addUsuario(u);
				u.addEvento(e);
			}
			db.getEM().merge(e);
			et.commit();
			response.sendRedirect("evento.jsp?id="+idEvento);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
