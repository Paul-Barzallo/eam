package TDAs;

public class Usuario {
	private String id;
	private String password;
	private String email;
	private int rango_edad;
	private String barrio;
	
	public Usuario(String id, String password, String email, int rango_edad, String barrio) {
		this.id = id;
		this.password = password;
		this.email = email;
		this.rango_edad = rango_edad;
		this.barrio = barrio;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getRango_edad() {
		return rango_edad;
	}

	public void setRango_edad(int rango_edad) {
		this.rango_edad = rango_edad;
	}

	public String getBarrio() {
		return barrio;
	}

	public void setBarrio(String barrio) {
		this.barrio = barrio;
	}
}
