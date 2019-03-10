package models;

import java.io.Serializable;
import javax.persistence.*;

import java.util.LinkedList;
import java.util.List;


/**
 * The persistent class for the usuarios database table.
 * 
 */
@Entity
@Table(name="usuarios")
@NamedQuery(name="Usuario.findAll", query="SELECT u FROM Usuario u")
public class Usuario implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="id_usuario")
	private String idUsuario;

	private boolean activo;

	private String barrio;

	private String email;

	@Column(name="es_admin")
	private boolean esAdmin;

	private String password;

	@Column(name="rango_edad")
	private int rangoEdad;

	//bi-directional many-to-one association to Admin
	@OneToMany(mappedBy="usuario")
	private List<Admin> admins;

	//bi-directional many-to-many association to Evento
	@ManyToMany(mappedBy="usuarios")
	private List<Evento> eventos;

	//bi-directional many-to-many association to Hobby
	@ManyToMany(mappedBy="usuarios")
	private List<Hobby> hobbies;

	public Usuario() {
		this.eventos = new LinkedList<>();
		this.hobbies = new LinkedList<>();
		this.admins = new LinkedList<>();
		this.activo = true;
		this.esAdmin = false;
		
	}

	public Usuario(String idUsuario, String password, String email, int rangoEdad, String barrio) {
		super();
		this.idUsuario = idUsuario;
		this.barrio = barrio;
		this.email = email;
		this.password = password;
		this.rangoEdad = rangoEdad;
		this.eventos = new LinkedList<>();
		this.hobbies = new LinkedList<>();
		this.admins = new LinkedList<>();
		this.activo = true;
		this.esAdmin = false;
		
	}

	public String getIdUsuario() {
		return this.idUsuario;
	}

	public void setIdUsuario(String idUsuario) {
		this.idUsuario = idUsuario;
	}

	public boolean getActivo() {
		return this.activo;
	}

	public void setActivo(boolean activo) {
		this.activo = activo;
	}

	public String getBarrio() {
		return this.barrio;
	}

	public void setBarrio(String barrio) {
		this.barrio = barrio;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean getEsAdmin() {
		return this.esAdmin;
	}

	public void setEsAdmin(boolean esAdmin) {
		this.esAdmin = esAdmin;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getRangoEdad() {
		return this.rangoEdad;
	}

	public void setRangoEdad(int rangoEdad) {
		this.rangoEdad = rangoEdad;
	}

	public List<Admin> getAdmins() {
		return this.admins;
	}

	public void setAdmins(List<Admin> admins) {
		this.admins = admins;
	}

	public Admin addAdmin(Admin admin) {
		getAdmins().add(admin);
		admin.setUsuario(this);

		return admin;
	}

	public Admin removeAdmin(Admin admin) {
		getAdmins().remove(admin);
		admin.setUsuario(null);

		return admin;
	}

	public List<Evento> getEventos() {
		return this.eventos;
	}

	public void setEventos(List<Evento> eventos) {
		this.eventos = eventos;
	}

	public List<Hobby> getHobbies() {
		return this.hobbies;
	}

	public void setHobbies(List<Hobby> hobbies) {
		this.hobbies = hobbies;
	}

}