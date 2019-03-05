package TDAs;

import java.time.*;

public class Evento {
	private int id;
	private String titulo;
	private String descripcion;
	private LocalDateTime fecha;
	private String barrio;
	private String direccion;
	private String ruta_img;
	private int num_img;
	private String creador;
	
	public Evento(int id, String titulo, String descripcion, LocalDateTime fecha, String barrio, String direccion, String ruta_img, int num_img, String creador) {
		this.id = id;
		this.titulo = titulo;
		this.descripcion = descripcion;
		this.fecha = fecha;
		this.barrio = barrio;
		this.direccion = direccion;
		this.ruta_img = ruta_img;
		this.num_img = num_img;
		this.creador = creador;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public LocalDateTime getFecha() {
		return fecha;
	}

	public void setFecha(LocalDateTime fecha) {
		this.fecha = fecha;
	}

	public String getBarrio() {
		return barrio;
	}

	public void setBarrio(String barrio) {
		this.barrio = barrio;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getRuta_img() {
		return ruta_img;
	}

	public void setRuta_img(String ruta_img) {
		this.ruta_img = ruta_img;
	}

	public int getNum_img() {
		return num_img;
	}

	public void setNum_img(int num_img) {
		this.num_img = num_img;
	}

	public String getCreador() {
		return creador;
	}

	public void setCreador(String creador) {
		this.creador = creador;
	}
}
