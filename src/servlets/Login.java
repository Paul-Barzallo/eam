package servlets;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.persistence.TypedQuery;
import javax.servlet.RequestDispatcher;
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
		/*System.out.println("entra en get");
		HttpSession sesion = request.getSession(true);
		System.out.println("id: "+sesion.getId());
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
				usuario = db.getEM().find(Usuario.class, user);
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
					} else {
						System.out.println("contraseña incorrecta:");
						System.out.println(password);
					}
				} else {
					System.out.println("usuario incorrecto:");
					System.out.println(user);
				}
			} else {
				System.out.println("sin cookies");
			}
		} */
	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException{
		Usuario usuario;
		String sql;
		TypedQuery<Usuario> query;
		
		String user = request.getParameter("user_login");
		String password = request.getParameter("pwd_login");
		String remember = request.getParameter("remember");
		
		HttpSession sesion = request.getSession(true);
		
		sql = "SELECT u FROM Usuario u WHERE u.password = ?1";
		query = db.getEM().createQuery(sql, Usuario.class);
		query.setParameter(1, MD5(password));
		usuario = query.getSingleResult();
		/*if (usuario == null) {
			sesion.invalidate();
		} else */if ((usuario.getIdUsuario().equals(user))){
			sesion.setAttribute("name", usuario.getIdUsuario());
			sesion.setAttribute("esAdmin", usuario.getAdmins().size());
			if (remember == "true") {
				Cookie cookie1 = new Cookie("user",user);
				Cookie cookie2 = new Cookie("password",usuario.getPassword());
				cookie1.setMaxAge(60*60*24*30); //1 mes
				cookie2.setMaxAge(60*60*24*30);
				//cookie1.setValue("123");
				//cookie1.setPath("\\");
				response.addCookie(cookie1);
				response.addCookie(cookie2);
			}
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			try {
				rd.forward(request, response);
			} catch(IOException e) {
				System.out.println(e);
			}
			
		} /*else {
			sesion.invalidate();
		}*/
	}
	
	private static String MD5(String text) {
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("MD5");
			md.update(text.getBytes());
		    byte byteData[] = md.digest();
		    StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < byteData.length; i++)
	            sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		} 
	}
}
