package ht.unaf.gestion.dao;

import ht.unaf.gestion.model.InscriptionCours;
import ht.unaf.gestion.util.JPAUtil;

import java.util.List;

public class InscriptionCoursDao extends GenericDao<InscriptionCours> {
    public InscriptionCoursDao() { super(InscriptionCours.class); }

    /** Toutes les inscriptions d'un étudiant (toutes sessions) = relevé de notes. */
    public List<InscriptionCours> parEtudiant(Long etudiantId) {
        return JPAUtil.lire(em -> em.createQuery(
                        "SELECT i FROM InscriptionCours i WHERE i.etudiant.id = :e ORDER BY i.session.id, i.cours.code", InscriptionCours.class)
                .setParameter("e", etudiantId).getResultList());
    }

    public List<InscriptionCours> parEtudiantEtSession(Long etudiantId, Long sessionId) {
        return JPAUtil.lire(em -> em.createQuery(
                        "SELECT i FROM InscriptionCours i WHERE i.etudiant.id = :e AND i.session.id = :s ORDER BY i.cours.jour, i.cours.heureDebut", InscriptionCours.class)
                .setParameter("e", etudiantId).setParameter("s", sessionId).getResultList());
    }

    /** Étudiants inscrits à un cours pour une session (vue professeur). */
    public List<InscriptionCours> parCoursEtSession(Long coursId, Long sessionId) {
        return JPAUtil.lire(em -> em.createQuery(
                        "SELECT i FROM InscriptionCours i WHERE i.cours.id = :c AND i.session.id = :s ORDER BY i.etudiant.nom", InscriptionCours.class)
                .setParameter("c", coursId).setParameter("s", sessionId).getResultList());
    }

    public long nombreInscrits(Long coursId, Long sessionId) {
        return JPAUtil.lire(em -> em.createQuery(
                        "SELECT COUNT(i) FROM InscriptionCours i WHERE i.cours.id = :c AND i.session.id = :s", Long.class)
                .setParameter("c", coursId).setParameter("s", sessionId).getSingleResult());
    }
}
