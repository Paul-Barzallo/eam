package servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.imageio.ImageIO;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import models.*;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import org.apache.commons.io.IOUtils;

import db.DB;

@WebServlet("/createEvent")
@MultipartConfig
public class CreateEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DB db; 

	public CreateEvent() {
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
		response.sendRedirect("iniciar_sesion.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession(true);
		String idusuario = (String)sesion.getAttribute("name");
		Usuario u = db.getEM().find(Usuario.class, idusuario);
		if (u != null) {
			if (u.getEsAdmin()) {
				Hobby hobby;
				Admin adm = u.getAdmins().get(0);
				Date date = null;
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
				
				String sql = "SELECT COUNT(e.idEvento) FROM Evento e";
				Query q = db.getEM().createQuery(sql);
				long idNewEvento = (long)q.getSingleResult()+1;
		
				String titulo = request.getParameter("titulo");
				String fecha = request.getParameter("fecha");
				String barrio = request.getParameter("barrio");
				String direccion = request.getParameter("direccion");
				String descripcion = request.getParameter("descripcion");
				String hobbies[] =  request.getParameterValues("hobbies");
				List<Part> fileParts = request.getParts().stream().filter(part -> "img".equals(part.getName())).collect(Collectors.toList());

				try {
					date = sdf.parse(fecha);
				} catch (ParseException e) {
					e.printStackTrace();
				}

				int numImg = 0;
				String rutaImg = "/evento"+idNewEvento;
				for (Part filePart : fileParts) {
					String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
					InputStream fileContent = filePart.getInputStream();
					
					File imgFolder = new File(this.getServletContext().getRealPath("/img")+rutaImg);
					imgFolder.mkdir();
					OutputStream outputStream = new FileOutputStream(new File(this.getServletContext().getRealPath("/img")+rutaImg+"/"+numImg+".jpg"));
					int read = 0;
					byte[] bytes = new byte[1024];
					while ((read = fileContent.read(bytes)) != -1) {
						outputStream.write(bytes, 0, read);
					}
					fileContent.close();
					outputStream.close();
					numImg++;
				}
				
				Evento newE = new Evento(titulo, descripcion, date, barrio, direccion, "img/"+rutaImg, numImg, adm);
				
				for(String h: hobbies) {
					newE.addHobbie(db.getEM().find(Hobby.class, Integer.parseInt(h)));
				}
				
				EntityTransaction et = db.getEM().getTransaction();
				et.begin();
				db.getEM().persist(newE);
				for (String h: hobbies) {
					hobby = db.getEM().find(Hobby.class, Integer.parseInt(h));
					hobby.addEvento(newE);
					db.getEM().merge(hobby);
				}
				et.commit();
				
				response.sendRedirect("proximos_eventos.jsp");
			}
		}
	}

}
