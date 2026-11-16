package ht.unaf.inscriptions.dao;

import ht.unaf.inscriptions.model.Cours;
import ht.unaf.inscriptions.util.JPAUtil;

import java.util.List;

public class CoursDao extends GenericDao<Cours> {
    public CoursDao() { super(Cours.class); }

    public List<Cours> parProgramme(Long programmeId) {
        return JPAUtil.lire(em -> em.createQuery("SELECT c FROM Cours c WHERE c.programme.id = :p ORDER BY c.code", Cours.class)
                .setParameter("p", programmeId).getResultList());
    }

    public List<Cours> parProfesseur(Long profId) {
        return JPAUtil.lire(em -> em.createQuery("SELECT c FROM Cours c WHERE c.professeur.id = :p ORDER BY c.code", Cours.class)
                .setParameter("p", profId).getResultList());
    }
}
