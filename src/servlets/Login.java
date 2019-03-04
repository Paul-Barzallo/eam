package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("user_login");
		String password = request.getParameter("pwd_login");
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
		PrintWriter respuesta = response.getWriter();

		if (correcto) {
			HttpSession sesion=request.getSession(true);
			if (sesion.getAttribute("typeUser") == null) {
				if (is_admin) sesion.setAttribute("typeUser","1");
				else sesion.setAttribute("typeUser","0");
			}
			respuesta.append("1");
		} else respuesta.append("0");
	}
}
