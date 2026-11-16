package ht.unaf.gestion.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;

import java.util.HashMap;
import java.util.Map;
import java.util.function.Consumer;
import java.util.function.Function;

/**
 * Point d'accès unique à JPA. Tomcat n'étant pas un serveur Jakarta EE complet,
 * on gère nous-mêmes l'EntityManagerFactory (créée une fois au démarrage).
 *
 * Les paramètres de connexion de persistence.xml peuvent être remplacés par des
 * variables d'environnement DB_URL, DB_USER, DB_PASSWORD (ou propriétés -Ddb.url ...).
 */
public final class JPAUtil {
    private static EntityManagerFactory emf;

    private JPAUtil() {}

    public static synchronized EntityManagerFactory getEmf() {
        if (emf == null) {
            Map<String, String> props = new HashMap<>();
            surcharge(props, "jakarta.persistence.jdbc.url", "db.url", "DB_URL");
            surcharge(props, "jakarta.persistence.jdbc.user", "db.user", "DB_USER");
            surcharge(props, "jakarta.persistence.jdbc.password", "db.password", "DB_PASSWORD");
            surcharge(props, "jakarta.persistence.jdbc.driver", "db.driver", "DB_DRIVER");
            emf = Persistence.createEntityManagerFactory("unafPU", props);
        }
        return emf;
    }

    private static void surcharge(Map<String, String> props, String cle, String sysProp, String env) {
        String v = System.getProperty(sysProp, System.getenv(env));
        if (v != null) props.put(cle, v);
    }

    /** Exécute une lecture (pas de transaction). */
    public static <R> R lire(Function<EntityManager, R> travail) {
        EntityManager em = getEmf().createEntityManager();
        try {
            return travail.apply(em);
        } finally {
            em.close();
        }
    }

    /** Exécute une écriture dans une transaction. */
    public static <R> R ecrire(Function<EntityManager, R> travail) {
        EntityManager em = getEmf().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            R r = travail.apply(em);
            tx.commit();
            return r;
        } catch (RuntimeException e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public static void executer(Consumer<EntityManager> travail) {
        ecrire(em -> { travail.accept(em); return null; });
    }

    public static synchronized void fermer() {
        if (emf != null && emf.isOpen()) emf.close();
        emf = null;
    }
}
