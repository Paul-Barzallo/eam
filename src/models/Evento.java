package models;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;


/**
 * The persistent class for the eventos database table.
 * 
 */
@Entity
@Table(name="eventos")
@NamedQuery(name="Evento.findAll", query="SELECT e FROM Evento e")
public class Evento implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id_evento")
	private int idEvento;

	private boolean aprobado;

	private String barrio;

	private boolean cancelado;

	private String descripcion;

	private String direccion;

	@Temporal(TemporalType.TIMESTAMP)
	private Date fecha;

	@Column(name="num_img")
	private int numImg;

	@Column(name="ruta_img")
	private String rutaImg;

	private String titulo;

	//bi-directional many-to-one association to Admin
	@ManyToOne
	@JoinColumn(name="id_creador")
	private Admin admin;

	//bi-directional many-to-many association to Usuario
	@ManyToMany
	@JoinTable(
		name="inscritos"
		, joinColumns={
			@JoinColumn(name="id_evento")
			}
		, inverseJoinColumns={
			@JoinColumn(name="id_usuario")
			}
		)
	private List<Usuario> usuarios;

	//bi-directional many-to-many association to Hobby
	@ManyToMany(mappedBy="eventos")
	private List<Hobby> hobbies;

	public Evento() {
		this.aprobado = true;
		this.cancelado = false;
		this.usuarios = new LinkedList<>();
		this.hobbies = new LinkedList<>();
	}

	public Evento(String titulo, String descripcion, Date fecha, String barrio, String direccion, 
			String rutaImg, int numImg, Admin admin) {
		super();
		this.barrio = barrio;
		this.descripcion = descripcion;
		this.direccion = direccion;
		this.fecha = fecha;
		this.numImg = numImg;
		this.rutaImg = rutaImg;
		this.titulo = titulo;
		this.admin = admin;
		this.aprobado = true;
		this.cancelado = false;
		this.usuarios = new LinkedList<>();
		this.hobbies = new LinkedList<>();
	}
	
	public void addUsuario(Usuario u) {
		this.usuarios.add(u);
	}
	
	public void removeUsuario(Usuario u) {
		this.usuarios.remove(u);
	}

	public int getIdEvento() {
		return this.idEvento;
	}

	public void setIdEvento(int idEvento) {
		this.idEvento = idEvento;
	}

	public boolean getAprobado() {
		return this.aprobado;
	}

	public void setAprobado(boolean aprobado) {
		this.aprobado = aprobado;
	}

	public String getBarrio() {
		return this.barrio;
	}

	public void setBarrio(String barrio) {
		this.barrio = barrio;
	}

	public boolean getCancelado() {
		return this.cancelado;
	}

	public void setCancelado(boolean cancelado) {
		this.cancelado = cancelado;
	}

	public String getDescripcion() {
		return this.descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getDireccion() {
		return this.direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public Date getFecha() {
		return this.fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	public int getNumImg() {
		return this.numImg;
	}

	public void setNumImg(int numImg) {
		this.numImg = numImg;
	}

	public String getRutaImg() {
		return this.rutaImg;
	}

	public void setRutaImg(String rutaImg) {
		this.rutaImg = rutaImg;
	}

	public String getTitulo() {
		return this.titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public Admin getAdmin() {
		return this.admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public List<Usuario> getUsuarios() {
		return this.usuarios;
	}

	public void setUsuarios(List<Usuario> usuarios) {
		this.usuarios = usuarios;
	}

	public List<Hobby> getHobbies() {
		return this.hobbies;
	}

	public void setHobbies(List<Hobby> hobbies) {
		this.hobbies = hobbies;
	}

}