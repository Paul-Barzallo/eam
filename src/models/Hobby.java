package models;

import java.io.Serializable;
import javax.persistence.*;

import java.util.LinkedList;
import java.util.List;


/**
 * The persistent class for the hobbies database table.
 * 
 */
@Entity
@Table(name="hobbies")
@NamedQuery(name="Hobby.findAll", query="SELECT h FROM Hobby h")
public class Hobby implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id_hobbie")
	private int idHobbie;

	private String descripcion;

	//bi-directional many-to-many association to Evento
	@ManyToMany
	@JoinTable(
		name="hobbieseventos"
		, joinColumns={
			@JoinColumn(name="id_hobbie")
			}
		, inverseJoinColumns={
			@JoinColumn(name="id_evento")
			}
		)
	private List<Evento> eventos;

	//bi-directional many-to-many association to Usuario
	@ManyToMany
	@JoinTable(
		name="hobbiesusuarios"
		, joinColumns={
			@JoinColumn(name="id_hobbie")
			}
		, inverseJoinColumns={
			@JoinColumn(name="id_usuario")
			}
		)
	private List<Usuario> usuarios;

	public Hobby() {
		this.eventos = new LinkedList<>();
		this.usuarios = new LinkedList<>();
	}

	public Hobby(String descripcion) {
		super();
		this.descripcion = descripcion;
		this.eventos = new LinkedList<>();
		this.usuarios = new LinkedList<>();
	}
	
	public void addEvento(Evento e) {
		this.eventos.add(e);
	}
	
	public void addUsuario(Usuario u) {
		this.usuarios.add(u);
	}

	public int getIdHobbie() {
		return this.idHobbie;
	}

	public void setIdHobbie(int idHobbie) {
		this.idHobbie = idHobbie;
	}

	public String getDescripcion() {
		return this.descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public List<Evento> getEventos() {
		return this.eventos;
	}

	public void setEventos(List<Evento> eventos) {
		this.eventos = eventos;
	}

	public List<Usuario> getUsuarios() {
		return this.usuarios;
	}

	public void setUsuarios(List<Usuario> usuarios) {
		this.usuarios = usuarios;
	}

}