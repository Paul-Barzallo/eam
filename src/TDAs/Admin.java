package TDAs;

public class Admin extends Usuario{
	private String nif;
	private String tlf;

	public Admin(String id, String password, String email, int rango_edad, String barrio, String nif, String tlf) {
		super(id, password, email, rango_edad, barrio);
		this.nif = nif;
		this.tlf = tlf;
	}

	public String getNif() {
		return nif;
	}

	public void setNif(String nif) {
		this.nif = nif;
	}

	public String getTlf() {
		return tlf;
	}

	public void setTlf(String tlf) {
		this.tlf = tlf;
	}
}
