package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.persistence.TypedQuery;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DB;
import models.Usuario;
import security.Encrypt;

@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DB db;   
	
    public Login() {
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException{
		HttpSession sesion = request.getSession(true);
		String name = (String)sesion.getAttribute("name");
		
		if (name == null) {
			Usuario usuario;
			String user = "";
			String password = "";
			Cookie[] cookies = request.getCookies();
			
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					System.out.println("cookie name: "+cookie.getName());
					System.out.println("cookie valor: "+cookie.getValue());
					if (cookie.getName().equals("user")) {
						user = cookie.getValue();
					} else if (cookie.getName().equals("password")) {
						password = cookie.getValue();
					}
				}
				try {
					usuario = db.getEM().find(Usuario.class, user);
				}
				catch (Exception e) {
					usuario = null;
				}
				if (usuario != null) {
					if (usuario.getPassword() == password) {
						sesion.setAttribute("name", user);
						sesion.setAttribute("esAdmin", usuario.getAdmins().size());
						Cookie cookie1 = new Cookie("user",user);
						Cookie cookie2 = new Cookie("password",usuario.getPassword());
						cookie1.setMaxAge(60*60*24*30); //1 mes
						cookie2.setMaxAge(60*60*24*30);
						cookie1.setPath("/");
						cookie2.setPath("/");
						response.addCookie(cookie1);
						response.addCookie(cookie2);
					} 
				} 
			} 
		} 
	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		PrintWriter respuesta;
		Usuario usuario;
		TypedQuery<Usuario> query;
		
		String user = request.getParameter("user");
		String password = request.getParameter("pwd");
		String remember = request.getParameter("remember");
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		respuesta = response.getWriter();
		
		HttpSession sesion = request.getSession(true);
		
		query = db.getEM().createQuery("SELECT u FROM Usuario u WHERE u.password = ?1", Usuario.class);
		query.setParameter(1, Encrypt.MD5(password));
		try {
			usuario = query.getSingleResult();
		} catch (Exception e) {
			usuario = null;
		}
		if (usuario == null) {
			respuesta.append("0");
		} else if ((usuario.getIdUsuario().equals(user))){
			sesion.setAttribute("name", usuario.getIdUsuario());
			sesion.setAttribute("esAdmin", usuario.getEsAdmin());
			if (remember == "true") {
				Cookie cookie1 = new Cookie("user",user);
				Cookie cookie2 = new Cookie("password",usuario.getPassword());
				cookie1.setMaxAge(60*60*24*30); //1 mes
				cookie2.setMaxAge(60*60*24*30);
				//cookie1.setValue("123");
				//cookie1.setPath("/");
				response.addCookie(cookie1);
				response.addCookie(cookie2);
			}
			respuesta.append("1");
		} else {
			respuesta.append("0");
		}
	}
	
	
}
