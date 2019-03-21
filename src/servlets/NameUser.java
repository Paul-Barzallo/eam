package servlets;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DB;

@WebServlet("/nameUser")
public class NameUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DB db;
       
    public NameUser() {
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
		String name = (String)sesion.getAttribute("name");
		response.getWriter().append(name);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
