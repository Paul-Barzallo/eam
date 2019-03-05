package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Logout() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession(false);
		response.setContentType("text/html");
        if(sesion!=null){
        	Cookie[] cookies = request.getCookies();
    		if (cookies != null) {
    			for (Cookie cookie : cookies) {
    				cookie.setMaxAge(0);
    				response.addCookie(cookie);
    			}
    		}
            sesion.invalidate();
        }
        response.sendRedirect("./");
	}

}
