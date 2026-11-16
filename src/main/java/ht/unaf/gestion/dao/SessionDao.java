package ht.unaf.gestion.dao;

import ht.unaf.gestion.model.SessionAcademique;
import ht.unaf.gestion.util.JPAUtil;

public class SessionDao extends GenericDao<SessionAcademique> {
    public SessionDao() { super(SessionAcademique.class); }

    public SessionAcademique active() {
        return JPAUtil.lire(em -> em.createQuery("SELECT s FROM SessionAcademique s WHERE s.active = true", SessionAcademique.class)
                .getResultStream().findFirst().orElse(null));
    }

    /** Active une session et désactive toutes les autres. */
    public void activer(Long id) {
        JPAUtil.executer(em -> {
            em.createQuery("UPDATE SessionAcademique s SET s.active = false").executeUpdate();
            em.createQuery("UPDATE SessionAcademique s SET s.active = true WHERE s.id = :id")
                    .setParameter("id", id).executeUpdate();
        });
    }
}
