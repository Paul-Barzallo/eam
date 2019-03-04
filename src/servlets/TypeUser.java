package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/typeUser")
public class TypeUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TypeUser() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		String typeUser;
		HttpSession sesion=request.getSession(true);
		typeUser = (String)sesion.getAttribute("typeUser");
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		PrintWriter respuesta = response.getWriter();
		respuesta.append(typeUser);
	}

}
