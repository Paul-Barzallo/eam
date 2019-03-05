package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String user = (String)request.getAttribute("user_login");
		String password = (String)request.getAttribute("pwd_login");
		HttpSession sesion = request.getSession(true);
		response = login(response, sesion, user, password, "false");
	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("user_login");
		String password = request.getParameter("pwd_login");
		String remember = request.getParameter("remember");
		HttpSession sesion = request.getSession(true);
		response = login(response, sesion, user, password, remember);
	}
	
	private HttpServletResponse login (HttpServletResponse response, HttpSession sesion, String user, String password, String remember) {
		boolean is_admin = false;
		boolean correcto = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/eam", "darnexb", "an28dres");
			Statement consulta = conexion.createStatement();
			ResultSet resultado = consulta.executeQuery("SELECT id_usuario, es_admin FROM Usuarios WHERE password LIKE MD5('"+password+"')");
			if (resultado.next()) if (user.equals(resultado.getString("id_usuario"))) {
				correcto = true;
				is_admin = resultado.getBoolean("es_admin");
			}
		} catch(Exception e) {
			System.out.println("ERROR: "+e);
		}
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		PrintWriter respuesta;
		try {
			respuesta = response.getWriter();
			if (correcto) {
				if (sesion.getAttribute("typeUser") == null) {
					if (is_admin)
						sesion.setAttribute("typeUser","1");
					else
						sesion.setAttribute("typeUser","0");
					if (remember == "true") {
						Cookie cookie1 = new Cookie("user",user);
						Cookie cookie2 = new Cookie("password",password);
						cookie1.setMaxAge(60*60*24*365); //1 año
						cookie2.setMaxAge(60*60*24*365); //1 año
						response.addCookie(cookie1);
						response.addCookie(cookie2);
					}
				}
				respuesta.append("1");
			} else {
				sesion.invalidate();
				respuesta.append("0");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return response;
	}
}
