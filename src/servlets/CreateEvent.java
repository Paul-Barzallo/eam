package servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.imageio.ImageIO;
import javax.persistence.TypedQuery;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import models.Usuario;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import org.apache.commons.io.IOUtils;

@WebServlet("/createEvent")
@MultipartConfig
public class CreateEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CreateEvent() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TypedQuery<Usuario> query;
		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

		String titulo = request.getParameter("titulo");
		String fecha = request.getParameter("fecha");
		String barrio = request.getParameter("barrio");
		String direccion = request.getParameter("direccion");
		String descripcion = request.getParameter("descripcion");
		String hobbies[] =  request.getParameterValues("hobbies");
		List<Part> fileParts = request.getParts().stream().filter(part -> "img".equals(part.getName())).collect(Collectors.toList());
		
		int count = 0;
		for (Part filePart : fileParts) {
			String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
			InputStream fileContent = filePart.getInputStream();

			OutputStream outputStream = new FileOutputStream(new File("./prueba"+count+".jpg"));
			int read = 0;
			byte[] bytes = new byte[1024];
			while ((read = fileContent.read(bytes)) != -1) {
				outputStream.write(bytes, 0, read);
			}
			fileContent.close();
			outputStream.close();
			count++;
		}

		try {
			date = sdf.parse(fecha);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		for(String h: hobbies) {
			System.out.println(h);
		}
	}

}
