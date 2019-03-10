package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.persistence.TypedQuery;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DB;
import models.Usuario;

/**
 * Servlet implementation class validateLogin
 */
@WebServlet("/validateLogin")
public class validateLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DB db; 

    public validateLogin() {
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter respuesta;
		String sql;
		TypedQuery<Usuario> query;
		Usuario usuario = null; 
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		respuesta = response.getWriter();
		
		String user = request.getParameter("user_login");
		String password = request.getParameter("pwd_login");
		
		sql = "SELECT u FROM Usuario u WHERE u.password = ?1";
		query = db.getEM().createQuery(sql, Usuario.class);
		query.setParameter(1, MD5(password));
		try {
			usuario = query.getSingleResult();
		} catch(Exception e) {}
		if (usuario == null) {
			respuesta.append("0");
		} else if ((usuario.getIdUsuario().equals(user))){
			respuesta.append("1");
		} else {
			respuesta.append("0");
		}
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
