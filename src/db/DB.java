package db;

import javax.persistence.*;

public class DB {
	EntityManagerFactory factory = null;
	EntityManager em = null;
	
	public DB() {
		factory = null;
		em = null;
		try {
			factory = Persistence.createEntityManagerFactory("eam");
			em = factory.createEntityManager();
		} catch (Exception err) {
			System.out.print("JPA error: ");
			System.out.println(err.getMessage());
		}
	}

	public EntityManagerFactory getFactory() {
		return factory;
	}

	public EntityManager getEM() {
		return em;
	}
}
