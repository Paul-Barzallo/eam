package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Remember
 */
@WebServlet("/remember")
public class Remember extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Remember() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = "";
		String password = "";
		Cookie[] cookies = request.getCookies();
		
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("user")) {
					user = cookie.getValue();
				} else if (cookie.getName().equals("password")) {
					password = cookie.getValue();
				}
			}
			request.setAttribute("user_login", user);
			request.setAttribute("pwd_login", password);
			RequestDispatcher dispatcher = request.getRequestDispatcher("login");
			dispatcher.include(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
